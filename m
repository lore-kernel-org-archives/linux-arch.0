From: Richard Kuo <rkuo@codeaurora.org>
Subject: Re: [PATCH v4 21/36] Hexagon: Add SMP support
Date: Wed, 21 Sep 2011 10:47:41 -0500
Message-ID: <20110921154741.GB6006@codeaurora.org>
References: <093448$3hstu8@wolverine01.qualcomm.com>
 <CAMk6uBmBqJsYSW+X9iY8Zc6BaC0jRy+a0CW0UV93gBAo98CzyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-hexagon-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMk6uBmBqJsYSW+X9iY8Zc6BaC0jRy+a0CW0UV93gBAo98CzyA@mail.gmail.com>
Sender: linux-hexagon-owner@vger.kernel.org
To: realmz paranoid <realmz6@gmail.com>
Cc: linux-arch@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Wed, Sep 21, 2011 at 10:10:27AM +0800, realmz paranoid wrote:
> > +/*
> > + * called once for each present cpu
> > + * apparently starts up the CPU and then
> > + * maintains control until "cpu_online(cpu)" is set.
> > + */
> > +
> __cpu_up only called once?

Well, for us currently, I'm pretty sure it's called only once, but perhaps
I should be a little more precise on the comment.


Thanks,
Richard Kuo

