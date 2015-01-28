From: Heiko Carstens <heiko.carstens-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>
Subject: Re: [opensuse-factory] Re: libsigsegv build fail
 with kernel 3.18.3
Date: Wed, 28 Jan 2015 08:38:37 +0100
Message-ID: <20150128073837.GC4633@osiris>
References: <1422361485.6648.71.camel@opensuse.org>
 <54C78756.9090605@suse.cz>
 <alpine.LSU.2.11.1501271347440.30227@nerf60.vanv.qr>
 <1422364084.6648.82.camel@opensuse.org>
 <s5h7fw8hvdp.wl-tiwai@suse.de>
 <CA+55aFyzy_wYHHnr2gDcYr7qcgOKM2557bRdg6RBa=cxrynd+Q@mail.gmail.com>
 <CA+55aFxRnj97rpSQvvzLJhpo7C8TQ-F=eB1Ry2n53AV1rN8mwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <opensuse-kernel+bounces-6420-glsk-opensuse-kernel=m.gmane.org-stAJ6ESoqRxg9hUCZPvPmw@public.gmane.org>
List-Post: <mailto:opensuse-kernel-stAJ6ESoqRxg9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:opensuse-kernel+help-stAJ6ESoqRxg9hUCZPvPmw@public.gmane.org>
List-Subscribe: <mailto:opensuse-kernel+subscribe-stAJ6ESoqRxg9hUCZPvPmw@public.gmane.org>
List-Unsubscribe: <mailto:opensuse-kernel+unsubscribe-stAJ6ESoqRxg9hUCZPvPmw@public.gmane.org>
List-Owner: <mailto:opensuse-kernel+owner-stAJ6ESoqRxg9hUCZPvPmw@public.gmane.org>
List-Archive: <http://lists.opensuse.org/opensuse-kernel/>
Content-Disposition: inline
In-Reply-To: <CA+55aFxRnj97rpSQvvzLJhpo7C8TQ-F=eB1Ry2n53AV1rN8mwA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, "linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, opensuse-factory-stAJ6ESoqRxg9hUCZPvPmw@public.gmane.org, OpenSUSE Kernel Team <opensuse-kernel-stAJ6ESoqRxg9hUCZPvPmw@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

On Tue, Jan 27, 2015 at 12:57:20PM -0800, Linus Torvalds wrote:
> [ Adding 'linux-arch' to the recipients, since this touches pretty
> much all architectures ]
[...]
> Can people take a look?
> 
> diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
> index 811937bb90be..9065d5aa3932 100644
> --- a/arch/s390/mm/fault.c
> +++ b/arch/s390/mm/fault.c
> @@ -374,6 +374,12 @@ static noinline void do_fault_error(struct pt_regs *regs, int fault)
>  				do_no_context(regs);
>  			else
>  				pagefault_out_of_memory();
> +		} else if (fault & VM_FAULT_SIGSEGV) {
> +			/* Kernel mode? Handle exceptions or die */
> +			if (!user_mode(regs))
> +				do_no_context(regs);
> +			else
> +				do_sigsegv(regs, SEGV_MAPERR);

s390 still compiles and boots with this patch applied.
