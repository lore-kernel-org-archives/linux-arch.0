From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v2 16/31] arm64: ELF definitions
Date: Thu, 16 Aug 2012 11:23:00 +0100
Message-ID: <20120816102300.GG31784@mudshark.cambridge.arm.com>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
 <1344966752-16102-17-git-send-email-catalin.marinas@arm.com>
 <201208151415.39570.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <201208151415.39570.arnd@arndb.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Catalin Marinas <Catalin.Marinas@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org

On Wed, Aug 15, 2012 at 03:15:39PM +0100, Arnd Bergmann wrote:
> On Tuesday 14 August 2012, Catalin Marinas wrote:
> > +
> > +void elf_set_personality(int personality)
> > +{
> > +       switch (personality & PER_MASK) {
> > +       case PER_LINUX:
> > +               clear_thread_flag(TIF_32BIT);
> > +               break;
> > +       case PER_LINUX32:
> > +               set_thread_flag(TIF_32BIT);
> > +               break;
> > +       default:
> > +               pr_warning("Process %s tried to assume unknown personality %d\n",
> > +                          current->comm, personality);
> > +               return;
> > +       }
> > +
> > +       current->personality = personality;
> > +}
> > +EXPORT_SYMBOL(elf_set_personality);
> 
> This looks wrong: PER_LINUX/PER_LINUX32 decides over the output of the
> uname system call, while TIF_32BIT decides over the instruction set
> when returning to user space. You definitely should not set the personality
> to the value you pass from the elf loader. Instead, just do
> 
> #define SET_PERSONALITY(ex) clear_thread_flag(TIF_32BIT);
> #defined COMPAT_SET_PERSONALITY(ex) set_thread_flag(TIF_32BIT);

In this case, won't uname be incorrect (aarch64l) for aarch32 tasks (which
expect something like armv8l)?

Will
