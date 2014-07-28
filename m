From: Oleg Nesterov <oleg@redhat.com>
Subject: TIF_NOHZ can escape nonhz mask? (Was: [PATCH v3 6/8] x86: Split
        syscall_trace_enter into two phases)
Date: Mon, 28 Jul 2014 20:58:03 +0200
Message-ID: <20140728185803.GA24663@redhat.com>
References: <cover.1405992946.git.luto@amacapital.net> <3f649f5658a163645e3ce15156176c325283762e.1405992946.git.luto@amacapital.net> <20140728173723.GA20993@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mips-bounce@linux-mips.org>
Content-Disposition: inline
In-Reply-To: <20140728173723.GA20993@redhat.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Andy Lutomirski <luto@amacapital.net>, Frederic Weisbecker <fweisbec@gmail.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>, Will Drewry <wad@chromium.org>, x86@kernel.org, linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org, linux-arch@vger.kernel.org, linux-security-module@vger.kernel.org, Alexei Starovoitov <ast@plumgrid.com>, hpa@zytor.com
List-Id: linux-arch.vger.kernel.org

Off-topic, but...

On 07/28, Oleg Nesterov wrote:
>
> But we should always call user_exit() unconditionally?

Frederic, don't we need the patch below? In fact clear_() can be moved
under "if ()" too. and probably copy_process() should clear this flag...

Or. __context_tracking_task_switch() can simply do

	 if (context_tracking_cpu_is_enabled())
	 	set_tsk_thread_flag(next, TIF_NOHZ);
	 else
	 	clear_tsk_thread_flag(next, TIF_NOHZ);

and then we can forget about copy_process(). Or I am totally confused?


I am also wondering if we can extend user_return_notifier to handle
enter/exit and kill TIF_NOHZ.

Oleg.

--- x/kernel/context_tracking.c
+++ x/kernel/context_tracking.c
@@ -202,7 +202,8 @@ void __context_tracking_task_switch(stru
 				    struct task_struct *next)
 {
 	clear_tsk_thread_flag(prev, TIF_NOHZ);
-	set_tsk_thread_flag(next, TIF_NOHZ);
+	if (context_tracking_cpu_is_enabled())
+		set_tsk_thread_flag(next, TIF_NOHZ);
 }
 
 #ifdef CONFIG_CONTEXT_TRACKING_FORCE
