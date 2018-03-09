From: Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [RFC PATCH 6/6] arch: add untagged_addr definition for other
 arches
Date: Fri, 9 Mar 2018 16:47:23 +0100
Message-ID: <CAAeHK+y=_imh4uNSAg_vj3DLAeDLcVP3a4f79dNMW=Ot5oLiZQ@mail.gmail.com>
References: <cover.1520600533.git.andreyknvl@google.com>
 <89b4bb181a0622d2c581699bb3814fc041078d04.1520600533.git.andreyknvl@google.com>
 <b320ff92-43ae-a479-35aa-4257b9c5430e@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
In-Reply-To: <b320ff92-43ae-a479-35aa-4257b9c5430e@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-snps-arc/>
List-Post: <mailto:linux-snps-arc@lists.infradead.org>
List-Help: <mailto:linux-snps-arc-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=subscribe>
Sender: "linux-snps-arc" <linux-snps-arc-bounces@lists.infradead.org>
Errors-To: linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: linux-mips@linux-mips.org, linux-sh@vger.kernel.org, Lee Smith <Lee.Smith@arm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Will Deacon <will.deacon@arm.com>, Paul Mackerras <paulus@samba.org>, Shaohua Li <shli@fb.com>, linux-arch@vger.kernel.org, Jacob Bramley <Jacob.Bramley@arm.com>, Michael Ellerman <mpe@ellerman.id.au>, "James E . J . Bottomley" <jejb@parisc-linux.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Catalin Marinas <catalin.marinas@arm.com>, Matt Turner <mattst88@gmail.com>, Evgeniy Stepanov <eugenis@google.com>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, adi-buildroot-devel@lists.sourceforge.net, Mike Rapoport <rppt@linux.vnet.ibm.com>, Al Viro <viro@zeniv.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>, Richard Henderson <rth@twiddle.net>, linux-cris-kernel@axis.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel>
List-Id: linux-arch.vger.kernel.org

On Fri, Mar 9, 2018 at 3:16 PM, Robin Murphy <robin.murphy@arm.com> wrote:
> On 09/03/18 14:02, Andrey Konovalov wrote:
>>
>> To allow arm64 syscalls accept tagged pointers from userspace, we must
>> untag them when they are passed to the kernel. Since untagging is done in
>> generic parts of the kernel (like the mm subsystem), the untagged_addr
>> macro should be defined for all architectures.
>
>
> Would it not suffice to have an "#ifndef untagged_addr..." fallback in
> linux/uaccess.h?
>

Hi Robin!

This approach is much better, I'll try it. This will also solve the
merge issues that Arnd mentioned.

Thanks!
