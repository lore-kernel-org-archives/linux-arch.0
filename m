From: Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH 15/19] csky: Build infrastructure
Date: Tue, 27 Mar 2018 10:39:29 +0800
Message-ID: <20180327023927.GA11454@guoren>
References: <cover.1521399976.git.ren_guo@c-sky.com>
 <c15b1fce07d0a19616026dfb927bfcbd88102b12.1521399976.git.ren_guo@c-sky.com>
 <CAK8P3a1rzS+MmubYqTE-8H89QnULcGbKth=eWTA5mJ5VLRNL0Q@mail.gmail.com>
 <20180320131342.GA31542@guoren>
 <CAK8P3a3pat6wQ+9gbf_wtp6+dur_h=Zp1896rogZHnehVnqVNA@mail.gmail.com>
 <20180321124137.GA21320@guoren>
 <CAK8P3a06MVAT35ZbG=gRkR1EDVdWPoT3bhwL+9fZSkmTHaDVBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAK8P3a06MVAT35ZbG=gRkR1EDVdWPoT3bhwL+9fZSkmTHaDVBw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Jason Cooper <jason@lakedaemon.net>, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org
List-Id: linux-arch.vger.kernel.org

On Mon, Mar 26, 2018 at 03:00:00PM +0200, Arnd Bergmann wrote:
> Ok, I understand the part about ck610 being incompatible, but I'm
> still not sure about the 8xx ones: Do you mean it's impossible to
> have one kernel that runs across all of them for some other reason,
> or is it something you haven't allowed because you see no use for it?
Sorry, Csky gcc need "-mcpu=ck807" or "-mcpu=ck810" or "-mcpu=ck860" to
determine the back-end policy. So I must seperate them with different vmlinux.

> This is basically the same question as above: For c610, using the fixed
> value is sufficient, because it's incompatible with the others. But if you want
> to run the same kernel on both ck810 and ck860, then it needs some form
> of runtime detection.
Sorry, currently no runtime detection.
But I agree with you that one vmlinux for all cpus is a good design for compat.

> On other architectures, the L1_CACHE_BYTES constant is the maximum
> possible cache line size, and the cache flush function uses the actual size
The same with above, we don't detect cpus on runtime. So we just make it
simple here.

> Ok. Just make sure that the DT always has this information as well,
> so this can be changed in the future when desired, without having to
> make incompatible changes to the devicetree binary files.
Ok

Best Regards
 Guo Ren
