require 'rglpk'

problem = Glpk_wrapper.glp_create_prob
tran = Glpk_wrapper.glp_mpl_alloc_wksp
result = Glpk_wrapper.glp_mpl_read_model tran, "playlist.mod", 1
raise "Could not parse model" unless result == 0

result = Glpk_wrapper.glp_mpl_read_data tran, "playlist.dat"
raise "Error loading data" unless result == 0

result = Glpk_wrapper.glp_mpl_generate tran, nil
raise "Error generating model" unless result == 0

Glpk_wrapper.glp_mpl_build_prob tran, problem



#row_count = Glpk_wrapper.glp_get_num_cols problem

#for i in 1..row_count
#  puts Glpk_wrapper.glp_get_col_name problem, i
#end

#puts row_count







Glpk_wrapper.glp_simplex problem, nil
Glpk_wrapper.glp_intopt problem, nil

#result = Glpk_wrapper.glp_mpl_postsolve tran, problem, Rglpk::GLP_SOL
#raise "Error postsolving model" unless result == 0

#glp_get_row_prim
#glp_get_col_prim


row_count = Glpk_wrapper.glp_get_num_cols problem
#
for i in 1..row_count
  name = Glpk_wrapper.glp_get_col_name problem, i
  value = Glpk_wrapper.glp_get_col_prim problem, i

  if (name.start_with? "selected_songs[" and value.to_i == 1)
    print name + "\n"
  end
  #puts name
  #puts Glpk_wrapper.glp_get_col_prim problem, i
end

#puts row_count


Glpk_wrapper.glp_mpl_free_wksp tran
Glpk_wrapper.glp_delete_prob problem
