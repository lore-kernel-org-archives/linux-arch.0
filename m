From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 17/31] arm64: System calls handling
Date: Tue, 21 Aug 2012 20:14:01 +0000
Message-ID: <201208212014.01837.arnd@arndb.de>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
 <201208151422.16335.arnd@arndb.de> <20120821175122.GI12708@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20120821175122.GI12708@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Will Deacon <Will.Deacon@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org

On Tuesday 21 August 2012, Catalin Marinas wrote:
> > > +asmlinkage long sys_mmap(unsigned long addr, unsigned long len,
> > > +                    unsigned long prot, unsigned long flags,
> > > +                    unsigned long fd, off_t off)
> > > +{
> > > +   if (offset_in_page(off) != 0)
> > > +           return -EINVAL;
> > > +
> > > +   return sys_mmap_pgoff(addr, len, prot, flags, fd, off >> PAGE_SHIFT);
> > > +}
> > 
> > I think
> > 
> > #define sys_mmap sys_mmap_pgoff 
> 
> There are slightly different semantics with the last argument of
> sys_mmap() which takes a byte offset. The sys_mmap_pgoff() function
> takes the offset shifted by PAGE_SHIFT (which is the same as sys_mmap2).
> 
> Looking at the other architectures, it makes sense to use a generic
> sys_mmap() implementation similar to the one above (or the ia-64, seems
> to be the most complete).
> 

Why that? The generic sys_mmap_pgoff was specifically added so new architectures
could just use that instead of having their own wrappers, see f8b72560.

	Arnd
