require 'rglpk'

class GlpkModel
  def self.execute(model_path, data_path)
    problem = Glpk_wrapper.glp_create_prob
    tran = Glpk_wrapper.glp_mpl_alloc_wksp

    begin
      result = Glpk_wrapper.glp_mpl_read_model tran, model_path, 1
      raise "Could not parse model" unless result == 0

      result = Glpk_wrapper.glp_mpl_read_data tran, data_path
      raise "Error loading data" unless result == 0

      result = Glpk_wrapper.glp_mpl_generate tran, nil
      raise "Error generating model" unless result == 0

      Glpk_wrapper.glp_mpl_build_prob tran, problem
      Glpk_wrapper.glp_simplex problem, nil
      Glpk_wrapper.glp_intopt problem, nil

      row_count = Glpk_wrapper.glp_get_num_cols problem

      for i in 1..row_count
        yield problem, i
      end
    ensure
      Glpk_wrapper.glp_mpl_free_wksp tran
      Glpk_wrapper.glp_delete_prob problem
    end
  end
end