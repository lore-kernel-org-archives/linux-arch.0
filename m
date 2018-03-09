From: Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [RFC PATCH 0/6] arm64: untag user pointers passed to the kernel
Date: Fri, 9 Mar 2018 18:58:00 +0100
Message-ID: <CAAeHK+xTEp-jcMDxNK4kCKcNtVbu4s4VXxzThsKMMFaTdBv0RQ@mail.gmail.com>
References: <cover.1520600533.git.andreyknvl@google.com>
 <963e112a-88a0-94bc-e6eb-0e9f9a6ee14a@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
In-Reply-To: <963e112a-88a0-94bc-e6eb-0e9f9a6ee14a@arm.com>
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

On Fri, Mar 9, 2018 at 3:15 PM, Robin Murphy <robin.murphy@arm.com> wrote:
> Hi Andrey,
>
> On 09/03/18 14:01, Andrey Konovalov wrote:
>>
>> arm64 has a feature called Top Byte Ignore, which allows to embed pointer
>> tags into the top byte of each pointer. Userspace programs (such as
>> HWASan, a memory debugging tool [1]) might use this feature and pass
>> tagged user pointers to the kernel through syscalls or other interfaces.
>
>
> If you propose changing the ABI, then
> Documentation/arm64/tagged-pointers.txt needs to reflect the new one, since
> passing nonzero tags via syscalls is currently explicitly forbidden.
>
> Robin.

Hi Robin!

I will include changes to Documentation/arm64/tagged-pointers.txt in
the next version.

Thanks!
