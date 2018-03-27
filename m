From: Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH 00/19] C-SKY(csky) Linux Kernel Port
Date: Tue, 27 Mar 2018 09:58:36 +0800
Message-ID: <20180327015835.GA10185@guoren>
References: <cover.1521399976.git.ren_guo@c-sky.com>
 <CAK8P3a3KwvNpYUXG-CqfF7V0GQ3sv_CoPmajq_+06aqkLiUFXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAK8P3a3KwvNpYUXG-CqfF7V0GQ3sv_CoPmajq_+06aqkLiUFXw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Jason Cooper <jason@lakedaemon.net>, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org
List-Id: linux-arch.vger.kernel.org

On Mon, Mar 26, 2018 at 03:30:34PM +0200, Arnd Bergmann wrote:
> Thanks for your submission. I had started reviewing it over a week
> ago, but never
> completed since I was travelling in the meantime. I've completed my first pass
> now and will wait for a new version before I take a more detailed look.
> 
> Overall, it looks nice, but changing the rest of the system call interface will
> take a while, this includes several points I've mentioned already, but
> to clarify,
> every file in arch/csky/include/uapi/asm/ needs to be carefully reviewed to
> contain only the minimum required additions to the asm-generic version.
> 
> Changing the ABI will obviously get in the way of testing, but this should
> be over as soon as the port is merged.
I entirely agree with you. After modify the unistd.h, we found a lot of
ltp-cases failed. We are dealing with them.

Best Regards
 Guo Ren
