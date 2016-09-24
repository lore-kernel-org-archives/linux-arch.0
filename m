From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] percpu: make this_cpu_generic_read notrace
Date: Sat, 24 Sep 2016 11:18:53 +0200
Message-ID: <4886672.oUR9U4H6le@wuerfel>
References: <1473497134-27807-1-git-send-email-zhang.chunyan@linaro.org> <CAG2=9p-v53OJovx4f=YsHD71vNz4EksJ_7tKfzMZeaK3qYxuog@mail.gmail.com> <20160916095309.GM3380@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160916095309.GM3380@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: Chunyan Zhang <zhang.chunyan@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, linux-arch@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Lyra Zhang <zhang.lyra@gmail.com>
List-Id: linux-arch.vger.kernel.org

On Friday, September 16, 2016 10:53:09 AM CEST Will Deacon wrote:
> On Fri, Sep 16, 2016 at 04:42:44PM +0800, Chunyan Zhang wrote:
> > Hi Will and Steven,
> > 
> > May I have a review or an acked-by from you on this patch so that Arnd
> > can pick it up.
> > 
> > I have tested this patch on arm qemu, I'm sure it can solve the
> > problem described in commit message.
> 
> It looks fine to me; we took your equivalent patch for arm64 already, so:
> 
> Acked-by: Will Deacon <will.deacon@arm.com>
> 

Applied to my asm-generic tree now, sorry for the delay,

	Arnd
