From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/6 v3] ptrace: Remove maxargs from
 task_current_syscall()
Date: Thu, 4 Apr 2019 09:52:11 +0200 (CEST)
Message-ID: <alpine.DEB.2.21.1904040951200.1833@nanos.tec.linutronix.de>
References: <20190401134104.676620247@goodmis.org> <20190401134420.601152379@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190401134420.601152379@goodmis.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@amacapital.net>, Roland McGrath <roland@hack.frob.com>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Dominik Brodowski <linux@dominikbrodowski.net>, Andy Lutomirski <luto@kernel.org>, Kees Cook <keescook@chromium.org>, "Eric W. Biederman" <ebiederm@xmission.com>, "Dmitry V. Levin" <ldv@altlinux.org>, Palmer Dabbelt <palmer@sifive.com>, Alexey Dobriyan <adobriyan@gma>
List-Id: linux-arch.vger.kernel.org

On Mon, 1 Apr 2019, Steven Rostedt wrote:

> From: "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>
> 
> task_current_syscall() has a single user that passes in 6 for maxargs, which
> is the maximum arguments that can be used to get system calls from
> syscall_get_arguments(). Instead of passing in a number of arguments to
> grab, just get 6 arguments. The args argument even specifies that it's an
> array of 6 items.
> 
> This will also allow changing syscall_get_arguments() to not get a variable
> number of arguments, but always grab 6.
> 
> Linus also suggested not passing in a bunch of arguments to
> task_current_syscall() but to instead pass in a pointer to a structure, and
> just fill the structure. struct seccomp_data has almost all the parameters
> that is needed except for the stack pointer (sp). As seccomp_data is part of
> uapi, and I'm afraid to change it, a new structure was created
> "syscall_info", which includes seccomp_data and adds the "sp" field.
> 
> Link: http://lkml.kernel.org/r/20161107213233.466776454@goodmis.org
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Alexey Dobriyan <adobriyan@gmail.com>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: linux-fsdevel@vger.kernel.org
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
