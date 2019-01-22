From: Firoz Khan <firoz.khan@linaro.org>
Subject: Re: [PATCH 0/3] arm64: system call table generation for asm-generic
Date: Tue, 22 Jan 2019 09:47:36 +0530
Message-ID: <CALxhOngnGKk==Cj+3EM1LkBK4FYRXNu4JxVg-d=3uttVcLwqQw@mail.gmail.com>
References: <1546530025-26014-1-git-send-email-firoz.khan@linaro.org>
 <20190119235650.GC26876@brain-police>
 <CAK8P3a1kiS7oF=eKLqPs6kKTYE1uTjhz++edH_J-tCUmXY2PNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAK8P3a1kiS7oF=eKLqPs6kKTYE1uTjhz++edH_J-tCUmXY2PNQ@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Kate Stewart <kstewart@linuxfoundation.org>, linux-arch <linux-arch@vger.kernel.org>, y2038 Mailman List <y2038@lists.linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Philippe Ombredanne <pombredanne@nexb.com>, Will Deacon <will.deacon@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Stefan Agner <stefan@agner.ch>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, Russell King <rmk+kernel@armlinux.org.uk>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Deepa Dinamani <deepa.kernel@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org

Hi Arnd, Will,

thanks for the email.

I'm want to abandon this patch series. Will post new patch series for
system call
table generation support for asm-generic and some other stuff together by end of
this week or early next week.

Thanks
Firoz

On Mon, 21 Jan 2019 at 21:24, Arnd Bergmann <arnd@arndb.de> wrote:
>
> n Sun, Jan 20, 2019 at 12:57 AM Will Deacon <will.deacon@arm.com> wrote:
> >
> > On Thu, Jan 03, 2019 at 09:10:22PM +0530, Firoz Khan wrote:
> > > This will be an automated scripts to provide easy support
> > > for add/modify/delete the system call entry by add in
> > > respective *.tbl file.
> > >
> > > System call table generation support for asm-generic is
> > > provide for arm64 architecture which will use the common
> > > scripts resides in scripts directory and use syscall.tbl
> > > syscall_arm32.tbl files as inputs. This implementation
> > > will replace asm-generic/unistd.h.
> > >
> > > This patch depends on:
> > >  https://lore.kernel.org/lkml/1546439331-18646-1-git-send-email-firoz.khan@linaro.org/
> > >  https://lore.kernel.org/lkml/1546520681-24453-1-git-send-email-firoz.khan@linaro.org/
> >
> > I'm having a hard time understanding what the benefit of this series is,
> > given that we only support EABI compat tasks. When adding a new compat
> > system call, you can't just blindly hook it up without checking whether it
> > needs a wrapper to deal with any type conversion etc, so really we're just
> > replacing one table with another as far as I can tell. What am I missing?
>
> The point that is missing in the description above is that all unistd.h
> and syscall.S files are now being generated from a .tbl file, across
> all architectures. This was already done on arm32, x86 and s390
> before 4.20, but is now done on all architectures that don't use
> the uapi/asm-generic/unistd.h header, and the arm32 compat version for
> arm64.
>
> The newly added file has the same format as all other tables, and
> will be easier to synchronize with the arm32 version, which has
> almost the same contents (arm32 has oabi support, arm64 has
> compat support).
>
> > I also really don't think we should be generating the 32-bit UAPI headers
> > from the 64-bit compat system call support (if that's what you're trying to
> > do -- make headers_check fails with your patches applied). arch/arm/ is the
> > canonical place for the 32-bit UAPI, and we're just implementing that.
>
> I think you just misread what Firoz was trying to say here: The
> arm64 uapi/asm/unistd.h file is now being generated from the
> generic syscall.tbl file, while the compat asm/unistd32.h file is not
> part of the UAPI. In both cases though, the data from the old files
> is being replaced with data in the more compact and (hopefully)
> more readable format.
>
>
>     Arnd
