From: Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH V6 08/33] csky: Process management and Signal
Date: Fri, 28 Sep 2018 21:10:47 +0800
Message-ID: <20180928131047.GC2082@guoren-Inspiron-7460>
References: <cover.1538058840.git.ren_guo@c-sky.com>
 <cover.1538058840.git.ren_guo@c-sky.com>
 <a51eb26bd9442a3e4d09e9785ae5ccaf2555a534.1538058840.git.ren_guo@c-sky.com>
 <87h8iaoh2k.fsf@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87h8iaoh2k.fsf@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: akpm@linux-foundation.org, arnd@arndb.de, daniel.lezcano@linaro.org, davem@davemloft.net, gregkh@linuxfoundation.org, jason@lakedaemon.net, marc.zyngier@arm.com, mark.rutland@arm.com, mchehab+samsung@kernel.org, peterz@infradead.org, robh@kernel.org, robh+dt@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, devicetree@vger.kernel.org, green.hu@gmail.com
List-Id: linux-arch.vger.kernel.org

On Thu, Sep 27, 2018 at 09:50:43PM +0200, Eric W. Biederman wrote:
> Guo Ren <ren_guo@c-sky.com> writes:
> 
> > --- /dev/null
> > +++ b/arch/csky/abiv2/fpu.c
> > +void fpu_fpe(struct pt_regs * regs)
> > +{
> > +	int sig;
> > +	unsigned int fesr;
> > +	siginfo_t info;
> > +
> > +	fesr = mfcr("cr<2, 2>");
> > +
> > +	if(fesr & FPE_ILLE){
> > +		info.si_code = ILL_ILLOPC;
> > +		sig = SIGILL;
> > +	}
> > +	else if(fesr & FPE_IDC){
> > +		info.si_code = ILL_ILLOPN;
> > +		sig = SIGILL;
> > +	}
> > +	else if(fesr & FPE_FEC){
> > +		sig = SIGFPE;
> > +		if(fesr & FPE_IOC){
> > +			info.si_code = FPE_FLTINV;
> > +		}
> > +		else if(fesr & FPE_DZC){
> > +			info.si_code = FPE_FLTDIV;
> > +		}
> > +		else if(fesr & FPE_UFC){
> > +			info.si_code = FPE_FLTUND;
> > +		}
> > +		else if(fesr & FPE_OFC){
> > +			info.si_code = FPE_FLTOVF;
> > +		}
> > +		else if(fesr & FPE_IXC){
> > +			info.si_code = FPE_FLTRES;
> > +		}
> > +		else {
> > +			info.si_code = NSIGFPE;
> > +		}
> > +	}
> > +	else {
> > +		info.si_code = NSIGFPE;
> > +		sig = SIGFPE;
> > +	}
> > +	info.si_signo = SIGFPE;
> > +	info.si_errno = 0;
> > +	info.si_addr = (void *)regs->pc;
> > +	force_sig_info(sig, &info, current);
> > +}
> 
> 
> This use of sending a signal is buggy.  It results in undefined values
> being copied to userspace.
> 
> Userspace should never be sent NSIGXXX as a si_code.  You can use
> FPE_FLTUNK for this default case.
Ok, thx for the tips. I'll fix it up in next patch-set.

> In new code please use force_sig_fault instead of force_sig_info in new
> code.  That saves you the trouble of messing with struct siginfo.
Ok, got it. Thx

Best Regards
 Guo Ren
