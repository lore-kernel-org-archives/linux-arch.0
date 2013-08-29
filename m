From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [gcv v3 08/35] tracing: Replace __get_cpu_var uses
Date: Thu, 29 Aug 2013 17:26:22 -0400
Message-ID: <20130829172622.3b458a80@gandalf.local.home>
References: <20130828193457.140443630@linux.com>
	<00000140c6781ceb-6c3e93f5-45d6-4b04-8034-e7cd4b5a77b5-000000@email.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:20015 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751755Ab3H2V0Z convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 29 Aug 2013 17:26:25 -0400
In-Reply-To: <00000140c6781ceb-6c3e93f5-45d6-4b04-8034-e7cd4b5a77b5-000000@email.amazonses.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Lameter <cl@linux.com>
Cc: Tejun Heo <tj@kernel.org>, akpm@linuxfoundation.org, Frederic Weisbecker <fweisbec@gmail.com>, Ingo Molnar <mingo@redhat.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 28 Aug 2013 19:48:16 +0000

> Index: linux/kernel/trace/trace.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux.orig/kernel/trace/trace.c	2013-08-26 14:25:53.000000000 -05=
00
> +++ linux/kernel/trace/trace.c	2013-08-26 14:26:29.464993617 -0500
> @@ -1676,7 +1676,7 @@ static void __ftrace_trace_stack(struct
>  	 */
>  	barrier();
>  	if (use_stack =3D=3D 1) {
> -		trace.entries		=3D &__get_cpu_var(ftrace_stack).calls[0];
> +		trace.entries		=3D this_cpu_ptr(ftrace_stack.calls);
>  		trace.max_entries	=3D FTRACE_STACK_MAX_ENTRIES;
> =20
>  		if (regs)


This patch fails to build:

kernel/trace/trace.c: In function =E2=80=98__ftrace_trace_stack=E2=80=99=
:
kernel/trace/trace.c:1679:20: error: cast specifies array type

-- Steve
