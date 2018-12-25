/* This file generated by AWKA */

#include <libawka.h>
#include <setjmp.h>

int _split_req = 0, _split_max = INT_MAX;

extern int _dol0_used;
extern char _dol0_only;
extern char _env_used;
extern int _max_base_gc, _max_fn_gc;
extern struct awka_fn_struct *_awkafn;
jmp_buf context;
a_VAR *OORS_awk = NULL;
a_VAR *x_awk = NULL;
a_VAR *y_awk = NULL;
a_VAR *vector_awk = NULL;
a_VAR *max_nr_awk = NULL;
a_VAR *max_nf_awk = NULL;
a_VAR *n_awk = NULL;

struct gvar_struct *_gvar;

a_VAR **_lvar;
a_VAR *_litd0_awka=NULL;
a_VAR *_lits0_awka=NULL;
void MAIN();
void END();

void
END()
{
  awka_varcpy(OORS_awk, a_bivar[a_ORS]);
  awka_strcpy(a_bivar[a_ORS], "");
  awka_vardblset(x_awk, 1);
  while ((awka_dbl2varcmp(x_awk->dval, max_nf_awk) <= 0))
  {
    awka_vardblset(y_awk, 1);
    while ((awka_dbl2varcmp(y_awk->dval, max_nr_awk) <= 0))
    {
      awka_print(NULL, 0, 0, awka_arg1(a_TEMP, awka_arraysearch(vector_awk, awka_arg2(a_TEMP, x_awk, y_awk), a_ARR_CREATE)));
      if ((awka_dbl2varcmp(y_awk->dval, max_nr_awk) != 0))
      {
        awka_printf(NULL, 0, 0, awka_vararg(a_TEMP, a_bivar[a_OFS], NULL));
      }
      awka_poi(y_awk);
    }
    awka_printf(NULL, 0, 0, awka_vararg(a_TEMP, OORS_awk, NULL));
    awka_poi(x_awk);
  }

}


void
MAIN()
{
  int i, _curfile;
  if (*(awka_gets(a_bivar[a_FILENAME])) == '\0')
    awka_strcpy(a_bivar[a_FILENAME], "");
  i = setjmp(context);
  while (awka_getline(a_TEMP, awka_dol0(0), awka_gets(a_bivar[a_FILENAME]), FALSE, TRUE)->dval > 0 && awka_setNF())
  {
    if ((awka_var2dblcmp(max_nf_awk, awka_NFget()->dval) < 0))
    {
      awka_vardblset(max_nf_awk, awka_NFget()->dval);
    }
    if ((awka_var2dblcmp(max_nr_awk, a_bivar[a_NR]->dval) < 0))
    {
      awka_vardblset(max_nr_awk, a_bivar[a_NR]->dval);
    }
    awka_vardblset(n_awk, 1);
    while (n_awk->dval <= awka_NFget()->dval)
    {
      awka_varcpy(awka_arraysearch(vector_awk, awka_arg2(a_TEMP, n_awk, a_bivar[a_NR]), a_ARR_CREATE), awka_doln(n_awk->dval, 0));
      awka_poi(n_awk);
    }
    nextrec:;
  }
}

int
main(int argc, char *argv[])
{
  _max_base_gc = 3;
  _max_fn_gc = 2;

  awka_varinit(OORS_awk);
  awka_varinit(x_awk);
  awka_varinit(y_awk);
  awka_varinit(vector_awk);
  awka_varinit(max_nr_awk);
  awka_varinit(max_nf_awk);
  awka_varinit(n_awk);

  awka_varinit(_litd0_awka); awka_setd(_litd0_awka) = 1;
  awka_varinit(_lits0_awka); awka_strcpy(_lits0_awka, "");

  if (!_lvar) {
    malloc( &_lvar, 3 * sizeof(a_VAR *) );
    _lvar[0] = _litd0_awka;
    _lvar[1] = _lits0_awka;
    _lvar[2] = NULL;
  }

  malloc( &_gvar, 8 * sizeof(struct gvar_struct) );
  awka_initgvar(0, "OORS_awk", OORS_awk);
  awka_initgvar(1, "x_awk", x_awk);
  awka_initgvar(2, "y_awk", y_awk);
  awka_initgvar(3, "vector_awk", vector_awk);
  vector_awk->type = a_VARARR;
  awka_initgvar(4, "max_nr_awk", max_nr_awk);
  awka_initgvar(5, "max_nf_awk", max_nf_awk);
  awka_initgvar(6, "n_awk", n_awk);
  _gvar[7].name = NULL;
  _gvar[7].var  = NULL;

  malloc( &_awkafn, 1 * sizeof(struct awka_fn_struct) );
  _awkafn[0].name = NULL;
  _awkafn[0].fn   = NULL;

  awka_init(argc, argv, "0.7.5", "12 July 2001");

  _split_req = 1;
  _dol0_used = 1;

  MAIN();
  END();

  free(_litd0_awka);
  free(_lits0_awka->ptr); free(_lits0_awka);

  awka_exit(0);
}
