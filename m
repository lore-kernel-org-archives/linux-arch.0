Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:42012 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932115AbcLGQii (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 7 Dec 2016 11:38:38 -0500
Date: Wed, 7 Dec 2016 16:32:10 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [Question] New mmap64 syscall?
Message-ID: <20161207163210.GB31779@e104818-lin.cambridge.arm.com>
References: <20161206185440.GA4654@yury-N73SV>
 <3014428.VXGdOARdm1@wuerfel>
 <20161207103451.GA869@yury-N73SV>
 <0F280FED-870A-42B5-ABC4-1976ACA32462@theobroma-systems.com>
 <20161207123944.GA11799@yury-N73SV>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20161207123944.GA11799@yury-N73SV>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yury Norov <ynorov@caviumnetworks.com>
Cc: "Dr.Philipp Tomsich" <philipp.tomsich@theobroma-systems.com>, Arnd Bergmann <arnd@arndb.de>, libc-alpha@sourceware.org, linux-arch@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, szabolcs.nagy@arm.com, heiko.carstens@de.ibm.com, cmetcalf@ezchip.com, "Joseph S. Myers" <joseph@codesourcery.com>, zhouchengming1@huawei.com, "Kapoor, Prasun" <Prasun.Kapoor@caviumnetworks.com>, Alexander Graf <agraf@suse.de>, geert@linux-m68k.org, kilobyte@angband.pl, manuel.montezelo@gmail.com, Andrew Pinski <pinskia@gmail.com>, linyongting@huawei.com, Alexey Klimov <klimov.linux@gmail.com>, broonie@kernel.org, "Zhangjian (Bamvor)" <bamvor.zhangjian@huawei.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>, Nathan_Lynch@mentor.com, schwidefsky@de.ibm.com, davem@davemloft.net, christoph.muellner@theobroma-systems.com
Message-ID: <20161207163210.YAJGW7GPjq3v09inqJoPzsX_Ub0w3PVZi0jjLMH48Qw@z>

On Wed, Dec 07, 2016 at 06:09:44PM +0530, Yury Norov wrote:
> On Wed, Dec 07, 2016 at 12:07:24PM +0100, Dr.Philipp Tomsich wrote:
> > [Resend, as my mail-client had insisted on using the wrong MIME type…]
> > 
> > > On 07 Dec 2016, at 11:34, Yury Norov <ynorov@caviumnetworks.com> wrote:
> > > 
> > >> If there is a use case for larger than 16TB offsets, we should add
> > >> the call on all architectures, probably using your approach 3. I don't
> > >> think that we should treat it as anything special for arm64 though.
> > > 
> > > From this point of view, 16+TB offset is a matter of 16+TB storage,
> > > and it's more than real. The other consideration to add it is that
> > > we have 64-bit support for offsets in syscalls like sys_llseek().
> > > So mmap64() will simply extend this support.
> > 
> > I believe the question is rather if the 16TB offset is a real use-case for ILP32.
> 
> This is not for ilp32, but for all 32-bit architectures - both native
> and compat. And because the scope is so generic, I think it's the
> strong reason for us to support true 64-bit offset in mmap().

When I mentioned it, I didn't realise that we already use 6 registers
for mmap(). While we can go up to 8 on AArch64/ILP32, I think Arnd has a
point that we don't want this to diverge from other new 32-bit
architectures. I don't really have a strong opinion either way here,
just a remark that AArch64/ILP32 already diverged from _current_ 32-bit
architectures by introducing 64-bit off_t in a 32-bit world. Introducing
an mmap64() at the same time wouldn't look too bad either.

> > This seems to bring the discussion full-circle, as this would indicate that 64bit is the 
> > preferred bit-width for all sizes, offsets, etc. throughout all filesystem-related calls 
> > (i.e. stat, seek, etc.).
> 
> AARCH64/ILP32 (and all new arches) exposes ino_t, off_t, blkcnt_t,
> fsblkcnt_t, fsfilcnt_t and rlim_t as 64-bit types. (Size_t should
> be 32-bit of course, because it's the same lengths as pointer.)
> 
> It allows to make syscalls that pass it support 64-bit values, refer
> Documentation/arm64/ilp32.txt for details. Stat and seek are both
> supporting 64-bit types. From this point of view, mmap() is the (only?)
> exception in current ILP32 ABI.

I thought ILP32 will use llseek() which has its own explicit way of
passing a 64-bit offset and the result written back by the kernel. We
wouldn't be able to use lseek() because of the return type.

> > But if that is the case, then we should have gone with 64bit arguments in a single
> > register for our ILP32 definition on AArch64.
>  
> There are 2 unrelated matters - the size of types, and the size of
> register. Most of 32-bit architectures has hardware limitation on
> register size (consider aarch32). And it doesn't mean that they are
> forced to stuck with 32-bit off_t etc. This is still opened question
> how to pass 64-bit parameters in aarch64/ilp32 because there we have
> the choice (the reason why it's RFC). If you have new ideas - welcome
> to that discussion. This topic also covers architectures that has to
> pass 64-bit parameters in a pair.

We've discussed this a few times already and the only sane option from
the _kernel_ perspective seemed to be either (a) close to native ABI for
ILP32 (and breaking POSIX) or (b) just a standard 32-bit ABI. The latter
implies splitting 64-bit values in register pairs, especially to avoid a
lot of annotations/wrapping in the generic kernel unistd.h file. IIRC,
we decided to go with option (b), so I don't think it's worth re-opening
that discussion.

> > In other words: Why not keep ILP32 simple an ask users that need a 16TB+ offset
> > to use LP64? It seems much more consistent with the other choices takes so far.
> 
> If user can switch to lp64, he doesn't need ilp32 at all, right? :)
> Also, I don't understand how true 64-bit offset in mmap64() would
> complicate this port.

It's more like the user wanting a quick transition from code that was
only ever compiled for AArch32 (or other 32-bit architecture) with a
goal of full LP64 transition on the long run. I have yet to see
convincing benchmarks showing ILP32 as an advantage over LP64 (of
course, I hear the argument of reading a pointer a loop is twice as fast
with a half-size pointer but I don't consider such benchmarks relevant).

-- 
Catalin
