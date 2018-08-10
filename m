From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 1/3] sh: Rename NR_syscalls macro to __NR_syscalls
Date: Fri, 10 Aug 2018 15:38:52 -0400
Message-ID: <20180810153852.720e2143@gandalf.local.home>
References: <1533793005-4525-2-git-send-email-firoz.khan@linaro.org>
        <201808092020.H3Qhfo8m%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201808092020.H3Qhfo8m%fengguang.wu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: kbuild test robot <lkp@intel.com>
Cc: Firoz Khan <firoz.khan@linaro.org>, kbuild-all@01.org, linux-sh@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, y2038@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com, marcin.juszkiewicz@linaro.org
List-Id: linux-arch.vger.kernel.org

On Thu, 9 Aug 2018 20:58:58 +0800
kbuild test robot <lkp@intel.com> wrote:

> Hi Firoz,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on linus/master]
> [also build test ERROR on v4.18-rc8 next-20180808]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Firoz-Khan/sh-Rename-NR_syscalls-macro-to-__NR_syscalls/20180809-171759
> config: sh-allmodconfig (attached as .config)
> compiler: sh4-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.2.0 make.cross ARCH=sh 
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from kernel/trace/trace_selftest_dynamic.c:3:0:
> >> kernel/trace/trace.h:243:53: error: 'NR_syscalls' undeclared here (not in a function); did you mean '__NR_syscalls'?  
>      struct trace_event_file __rcu *enter_syscall_files[NR_syscalls];
>                                                         ^~~~~~~~~~~
>                                                         __NR_syscalls
> --
>    In file included from kernel/trace/trace_output.h:6:0,
>                     from kernel/trace/trace_syscalls.c:12:
> >> kernel/trace/trace.h:243:53: error: 'NR_syscalls' undeclared here (not in a function); did you mean '__NR_syscalls'?  
>      struct trace_event_file __rcu *enter_syscall_files[NR_syscalls];
>                                                         ^~~~~~~~~~~
>                                                         __NR_syscalls

Most archs have a:

#define NR_syscalls __NR_syscalls

-- Steve

>    In file included from include/linux/smp.h:11:0,
>                     from include/linux/tracepoint.h:17,
>                     from include/trace/syscall.h:5,
>                     from kernel/trace/trace_syscalls.c:2:
>    kernel/trace/trace_syscalls.c:559:23: warning: 'enabled_perf_exit_syscalls' defined but not used [-Wunused-variable]
>     static DECLARE_BITMAP(enabled_perf_exit_syscalls, NR_syscalls);
>                           ^
>    include/linux/types.h:11:16: note: in definition of macro 'DECLARE_BITMAP'
>      unsigned long name[BITS_TO_LONGS(bits)]
>                    ^~~~
>    kernel/trace/trace_syscalls.c:558:23: warning: 'enabled_perf_enter_syscalls' defined but not used [-Wunused-variable]
>     static DECLARE_BITMAP(enabled_perf_enter_syscalls, NR_syscalls);
>                           ^
>    include/linux/types.h:11:16: note: in definition of macro 'DECLARE_BITMAP'
>      unsigned long name[BITS_TO_LONGS(bits)]
>                    ^~~~
> 
> vim +243 kernel/trace/trace.h
> 
> 490901078 Steven Rostedt (Red Hat  2015-09-24  196) 
> bc0c38d13 Steven Rostedt           2008-05-12  197  /*
> bc0c38d13 Steven Rostedt           2008-05-12  198   * The trace array - an array of per-CPU trace arrays. This is the
> bc0c38d13 Steven Rostedt           2008-05-12  199   * highest level data structure that individual tracers deal with.
> bc0c38d13 Steven Rostedt           2008-05-12  200   * They have on/off state as well:
> bc0c38d13 Steven Rostedt           2008-05-12  201   */
> bc0c38d13 Steven Rostedt           2008-05-12  202  struct trace_array {
> ae63b31e4 Steven Rostedt           2012-05-03  203  	struct list_head	list;
> 277ba0446 Steven Rostedt           2012-08-03  204  	char			*name;
> 12883efb6 Steven Rostedt (Red Hat  2013-03-05  205) 	struct trace_buffer	trace_buffer;
> 12883efb6 Steven Rostedt (Red Hat  2013-03-05  206) #ifdef CONFIG_TRACER_MAX_TRACE
> 12883efb6 Steven Rostedt (Red Hat  2013-03-05  207) 	/*
> 12883efb6 Steven Rostedt (Red Hat  2013-03-05  208) 	 * The max_buffer is used to snapshot the trace when a maximum
> 12883efb6 Steven Rostedt (Red Hat  2013-03-05  209) 	 * latency is reached, or when the user initiates a snapshot.
> 12883efb6 Steven Rostedt (Red Hat  2013-03-05  210) 	 * Some tracers will use this to store a maximum trace while
> 12883efb6 Steven Rostedt (Red Hat  2013-03-05  211) 	 * it continues examining live traces.
> 12883efb6 Steven Rostedt (Red Hat  2013-03-05  212) 	 *
> 12883efb6 Steven Rostedt (Red Hat  2013-03-05  213) 	 * The buffers for the max_buffer are set up the same as the trace_buffer
> 12883efb6 Steven Rostedt (Red Hat  2013-03-05  214) 	 * When a snapshot is taken, the buffer of the max_buffer is swapped
> 12883efb6 Steven Rostedt (Red Hat  2013-03-05  215) 	 * with the buffer of the trace_buffer and the buffers are reset for
> 12883efb6 Steven Rostedt (Red Hat  2013-03-05  216) 	 * the trace_buffer so the tracing can continue.
> 12883efb6 Steven Rostedt (Red Hat  2013-03-05  217) 	 */
> 12883efb6 Steven Rostedt (Red Hat  2013-03-05  218) 	struct trace_buffer	max_buffer;
> 45ad21ca5 Steven Rostedt (Red Hat  2013-03-05  219) 	bool			allocated_snapshot;
> f971cc9aa Steven Rostedt (Red Hat  2016-09-07  220) #endif
> f971cc9aa Steven Rostedt (Red Hat  2016-09-07  221) #if defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER)
> 6d9b3fa5e Steven Rostedt (Red Hat  2014-01-14  222) 	unsigned long		max_latency;
> 12883efb6 Steven Rostedt (Red Hat  2013-03-05  223) #endif
> 490901078 Steven Rostedt (Red Hat  2015-09-24  224) 	struct trace_pid_list	__rcu *filtered_pids;
> 0b9b12c1b Steven Rostedt (Red Hat  2014-01-14  225) 	/*
> 0b9b12c1b Steven Rostedt (Red Hat  2014-01-14  226) 	 * max_lock is used to protect the swapping of buffers
> 0b9b12c1b Steven Rostedt (Red Hat  2014-01-14  227) 	 * when taking a max snapshot. The buffers themselves are
> 0b9b12c1b Steven Rostedt (Red Hat  2014-01-14  228) 	 * protected by per_cpu spinlocks. But the action of the swap
> 0b9b12c1b Steven Rostedt (Red Hat  2014-01-14  229) 	 * needs its own lock.
> 0b9b12c1b Steven Rostedt (Red Hat  2014-01-14  230) 	 *
> 0b9b12c1b Steven Rostedt (Red Hat  2014-01-14  231) 	 * This is defined as a arch_spinlock_t in order to help
> 0b9b12c1b Steven Rostedt (Red Hat  2014-01-14  232) 	 * with performance when lockdep debugging is enabled.
> 0b9b12c1b Steven Rostedt (Red Hat  2014-01-14  233) 	 *
> 0b9b12c1b Steven Rostedt (Red Hat  2014-01-14  234) 	 * It is also used in other places outside the update_max_tr
> 0b9b12c1b Steven Rostedt (Red Hat  2014-01-14  235) 	 * so it needs to be defined outside of the
> 0b9b12c1b Steven Rostedt (Red Hat  2014-01-14  236) 	 * CONFIG_TRACER_MAX_TRACE.
> 0b9b12c1b Steven Rostedt (Red Hat  2014-01-14  237) 	 */
> 0b9b12c1b Steven Rostedt (Red Hat  2014-01-14  238) 	arch_spinlock_t		max_lock;
> 499e54705 Steven Rostedt           2012-02-22  239  	int			buffer_disabled;
> 12ab74ee0 Steven Rostedt           2012-08-08  240  #ifdef CONFIG_FTRACE_SYSCALLS
> 12ab74ee0 Steven Rostedt           2012-08-08  241  	int			sys_refcount_enter;
> 12ab74ee0 Steven Rostedt           2012-08-08  242  	int			sys_refcount_exit;
> 7f1d2f821 Steven Rostedt (Red Hat  2015-05-05 @243) 	struct trace_event_file __rcu *enter_syscall_files[NR_syscalls];
> 7f1d2f821 Steven Rostedt (Red Hat  2015-05-05  244) 	struct trace_event_file __rcu *exit_syscall_files[NR_syscalls];
> 12ab74ee0 Steven Rostedt           2012-08-08  245  #endif
> 2b6080f28 Steven Rostedt           2012-05-11  246  	int			stop_count;
> 2b6080f28 Steven Rostedt           2012-05-11  247  	int			clock_id;
> 37aea98b8 Steven Rostedt (Red Hat  2015-09-30  248) 	int			nr_topts;
> 065e63f95 Steven Rostedt (VMware   2017-08-31  249) 	bool			clear_trace;
> 2b6080f28 Steven Rostedt           2012-05-11  250  	struct tracer		*current_trace;
> 983f938ae Steven Rostedt (Red Hat  2015-09-30  251) 	unsigned int		trace_flags;
> 9a38a8856 Steven Rostedt (Red Hat  2015-09-30  252) 	unsigned char		trace_flags_index[TRACE_FLAGS_MAX_SIZE];
> ae63b31e4 Steven Rostedt           2012-05-03  253  	unsigned int		flags;
> 2b6080f28 Steven Rostedt           2012-05-11  254  	raw_spinlock_t		start_lock;
> ae63b31e4 Steven Rostedt           2012-05-03  255  	struct dentry		*dir;
> 2b6080f28 Steven Rostedt           2012-05-11  256  	struct dentry		*options;
> 2b6080f28 Steven Rostedt           2012-05-11  257  	struct dentry		*percpu_dir;
> ae63b31e4 Steven Rostedt           2012-05-03  258  	struct dentry		*event_dir;
> 37aea98b8 Steven Rostedt (Red Hat  2015-09-30  259) 	struct trace_options	*topts;
> ae63b31e4 Steven Rostedt           2012-05-03  260  	struct list_head	systems;
> ae63b31e4 Steven Rostedt           2012-05-03  261  	struct list_head	events;
> 3dd809536 Steven Rostedt (VMware   2018-05-09  262) 	struct trace_event_file *trace_marker_file;
> ccfe9e42e Alexander Z Lam          2013-08-08  263  	cpumask_var_t		tracing_cpumask; /* only trace on set CPUs */
> a695cb581 Steven Rostedt (Red Hat  2013-03-06  264) 	int			ref;
> f20a58062 Steven Rostedt (Red Hat  2013-11-07  265) #ifdef CONFIG_FUNCTION_TRACER
> f20a58062 Steven Rostedt (Red Hat  2013-11-07  266) 	struct ftrace_ops	*ops;
> 345ddcc88 Steven Rostedt (Red Hat  2016-04-22  267) 	struct trace_pid_list	__rcu *function_pids;
> 04ec7bb64 Steven Rostedt (VMware   2017-04-05  268) #ifdef CONFIG_DYNAMIC_FTRACE
> 673feb9d7 Steven Rostedt (VMware   2017-06-23  269) 	/* All of these are protected by the ftrace_lock */
> 04ec7bb64 Steven Rostedt (VMware   2017-04-05  270) 	struct list_head	func_probes;
> 673feb9d7 Steven Rostedt (VMware   2017-06-23  271) 	struct list_head	mod_trace;
> 673feb9d7 Steven Rostedt (VMware   2017-06-23  272) 	struct list_head	mod_notrace;
> 04ec7bb64 Steven Rostedt (VMware   2017-04-05  273) #endif
> f20a58062 Steven Rostedt (Red Hat  2013-11-07  274) 	/* function tracing enabled */
> f20a58062 Steven Rostedt (Red Hat  2013-11-07  275) 	int			function_enabled;
> f20a58062 Steven Rostedt (Red Hat  2013-11-07  276) #endif
> 00b414529 Tom Zanussi              2018-01-15  277  	int			time_stamp_abs_ref;
> 067fe038e Tom Zanussi              2018-01-15  278  	struct list_head	hist_vars;
> bc0c38d13 Steven Rostedt           2008-05-12  279  };
> bc0c38d13 Steven Rostedt           2008-05-12  280  
> 
> :::::: The code at line 243 was first introduced by commit
> :::::: 7f1d2f8210195c8c309d424a77dbf06a6d2186f4 tracing: Rename ftrace_event_file to trace_event_file
> 
> :::::: TO: Steven Rostedt (Red Hat) <rostedt@goodmis.org>
> :::::: CC: Steven Rostedt <rostedt@goodmis.org>
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
