From: Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH V6 05/33] csky: System Call
Date: Sun, 30 Sep 2018 01:05:00 +0800
Message-ID: <20180929170500.GE27796@guoren-Inspiron-7460>
References: <cover.1538058840.git.ren_guo@c-sky.com>
 <c98f0fc0103196e839bdc016f50f227fce8c54b1.1538058840.git.ren_guo@c-sky.com>
 <20180928161609.GD19827@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180928161609.GD19827@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: akpm@linux-foundation.org, arnd@arndb.de, daniel.lezcano@linaro.org, davem@davemloft.net, gregkh@linuxfoundation.org, jason@lakedaemon.net, marc.zyngier@arm.com, mark.rutland@arm.com, mchehab+samsung@kernel.org, peterz@infradead.org, robh@kernel.org, robh+dt@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, devicetree@vger.kernel.org, green.hu@gmail.com
List-Id: linux-arch.vger.kernel.org

On Fri, Sep 28, 2018 at 09:16:09AM -0700, Christoph Hellwig wrote:
> > +
> > +static inline void
> > +syscall_set_arguments(struct task_struct *task, struct pt_regs *regs,
> > +		      unsigned int i, unsigned int n, const unsigned long *args)
> > +{
> > +	BUG_ON(i + n > 6);
> > +        if (i == 0) {
> 
> Please fix your indentation - again checkpatch.pl will be helpful (even
> if it sometimes is a littler overzealous).
Ok, I'll use checkpatch.pl.
