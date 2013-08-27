From: Hans-Christian Egtvedt <egtvedt@samfundet.no>
Subject: Re: [guv v2 25/31] avr32: Replace __get_cpu_var uses
Date: Tue, 27 Aug 2013 08:58:53 +0200
Message-ID: <20130827065853.GA2153@samfundet.no>
References: <20130826204351.725357339@linux.com>
 <00000140bc69acd0-a726b027-118a-48bd-a832-a6454a9dfe04-000000@email.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <00000140bc69acd0-a726b027-118a-48bd-a832-a6454a9dfe04-000000@email.amazonses.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Lameter <cl@linux.com>
Cc: Tejun Heo <tj@kernel.org>, akpm@linuxfoundation.org, Haavard Skinnemoen <hskinnemoen@gmail.com>, linux-arch@vger.kernel.org, Steven Rostedt <srostedt@redhat.com>, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Around Mon 26 Aug 2013 20:56:16 +0000 or thereabout, Christoph Lameter wrote:

<snipp reasoning>

> Index: linux/arch/avr32/kernel/kprobes.c
> ===================================================================
> --- linux.orig/arch/avr32/kernel/kprobes.c	2013-08-26 13:25:18.000000000 -0500
> +++ linux/arch/avr32/kernel/kprobes.c	2013-08-26 13:27:09.758485808 -0500
> @@ -104,7 +104,7 @@ static void __kprobes resume_execution(s
>  
>  static void __kprobes set_current_kprobe(struct kprobe *p)
>  {
> -	__get_cpu_var(current_kprobe) = p;
> +	__this_cpu_write(current_kprobe, p);
>  }
>  
>  static int __kprobes kprobe_handler(struct pt_regs *regs)

Acked-by: Hans-Christian Egtvedt <egtvedt@samfundet.no>

-- 
mvh
Hans-Christian Egtvedt
