From: Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 22/41] sparc: switch to ->get2()
Date: Tue, 30 Jun 2020 14:16:40 +0100
Message-ID: <20200630131640.GE2786714@ZenIV.linux.org.uk>
References: <20200629182349.GA2786714@ZenIV.linux.org.uk>
 <20200629182628.529995-1-viro@ZenIV.linux.org.uk>
 <20200629182628.529995-22-viro@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200629182628.529995-22-viro@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>, Tony Luck <tony.luck@intel.com>, Will Deacon <will@kernel.org>
List-Id: linux-arch.vger.kernel.org

On Mon, Jun 29, 2020 at 07:26:09PM +0100, Al Viro wrote:
  
>  static int getregs64_get(struct task_struct *target,
>  			 const struct user_regset *regset,
> -			 unsigned int pos, unsigned int count,
> -			 void *kbuf, void __user *ubuf)
> +			 struct membuf to)
>  {
>  	const struct pt_regs *regs = task_pt_regs(target);
> -	int ret;
>  
>  	if (target == current)
>  		flushw_user();
>  
> -	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
> -				  regs->u_regs + 1,
> -				  0, 15 * sizeof(u64));
> -	if (!ret)
> -		ret = user_regset_copyout_zero(&pos, &count, &kbuf, &ubuf,
> -				  15 * sizeof(u64), 16 * sizeof(u64));
> -	if (!ret) {
> -		/* TSTATE, TPC, TNPC */
> -		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
> -					  &regs->tstate,
> -					  16 * sizeof(u64),
> -					  19 * sizeof(u64));
> -	}
> -	if (!ret) {
> -		unsigned long y = regs->y;
> -
> -		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
> -					  &y,
> -					  19 * sizeof(u64),
> -					  20 * sizeof(u64));
> -	}
> -	return ret;
> +	membuf_write(&to, regs->u_regs + 1, 15 * sizeof(u64));
> +	return membuf_store(&to, (u64)0);
	^^^^^^
Er...  That should be simply

+	membuf_store(&to, (u64)0);

> +	membuf_write(&to, &regs->tstate, 3 * sizeof(u64));
> +	return membuf_store(&to, (u64)regs->y);
>  }
