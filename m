From: Matthias Maennich <maennich-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v3 00/11] Symbol Namespaces
Date: Wed, 21 Aug 2019 15:03:41 +0100
Message-ID: <20190821140341.GA126314@google.com>
References: <20190813121733.52480-1-maennich@google.com>
 <20190821114955.12788-1-maennich@google.com>
 <20190821131140.GC2349@hirez.programming.kicks-ass.net>
 <20190821133846.GC4890@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20190821133846.GC4890-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: kstewart-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, oneukum-IBi9RG/b67k@public.gmane.org, linux-aspeed-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Toru Komatsu <k0ma-h7Lmzv2voGl4Eiagz67IpQ@public.gmane.org>, Mauro Carvalho Chehab <mchehab+samsung-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Nicolas Ferre <nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>, David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org, Will Deacon <will-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, patches-yzvPICuk2AA4QjBA90+/kJqQE7yCjDx5@public.gmane.org, Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>, hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org, joel-QYYGw3jwrUn5owFQY34kdNi2O/JbrIOy@public.gmane.org, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org, cocci-/FJkirnvOdkvYVN+rsErww@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Benjamin Fair <benjaminfair-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, linux-scsi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nancy Yuen <yuenn-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, openbmc-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lucas.de.marchi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, usb-storage-ijkIwGHArpdIPJnuZ7Njw4oP9KaGy4wf@public.gmane.org, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org, NX
List-Id: linux-arch.vger.kernel.org

On Wed, 21 Aug, 06:38, Greg Kroah-Hartman wrote:
>On Wed, Aug 21, 2019 at 03:11:40PM +0200, Peter Zijlstra wrote:
>> On Wed, Aug 21, 2019 at 12:49:15PM +0100, Matthias Maennich wrote:
>> > As of Linux 5.3-rc5, there are 31205 [1] exported symbols in the kernel.
>> > That is a growth of roughly 1000 symbols since 4.17 (30206 [2]).  There
>> > seems to be some consensus amongst kernel devs that the export surface
>> > is too large, and hard to reason about.
>> >
>> > Generally, these symbols fall in one of these categories:
>> > 1) Symbols actually meant for drivers
>> > 2) Symbols that are only exported because functionality is split over
>> >    multiple modules, yet they really shouldn't be used by modules outside
>> >    of their own subsystem
>> > 3) Symbols really only meant for in-tree use
>> >
>> > When module developers try to upstream their code, it regularly turns
>> > out that they are using exported symbols that they really shouldn't be
>> > using. This problem is even bigger for drivers that are currently
>> > out-of-tree, which may be using many symbols that they shouldn't be
>> > using, and that break when those symbols are removed or modified.
>> >
>> > This patch allows subsystem maintainers to partition their exported
>> > symbols into separate namespaces, and module authors to import such
>> > namespaces only when needed.
>> >
>> > This allows subsystem maintainers to more easily limit availability of
>> > these namespaced symbols to other parts of the kernel. It can also be
>> > used to partition the set of exported symbols for documentation
>> > purposes; for example, a set of symbols that is really only used for
>> > debugging could be in a "SUBSYSTEM_DEBUG" namespace.
>>
>> I'm missing how one can prohibit these random out of tree modules from
>> doing MODULE_IMPORT_NS().
>
>Nothing, but then they are explicitly being "bad" :)
>

As a side effect of this implementation (namespace imports via modinfo
tags), imports are very visible for (out-of-tree) modules, e.g.

$ modinfo drivers/usb/storage/ums-usbat.ko
  filename:       drivers/usb/storage/ums-usbat.ko
  import_ns:      USB_STORAGE
  license:        GPL
  author:         ...
  ...

>> That is; suppose I stick all the preempt_notifier symbols in a KVM
>> namespace, how do I enforce no out-of-tree modules ever do
>> MODULE_IMPORT_NS(KVM) and gain access?
>>

That is actually a feature worth following up: Restricting the
namespaces that can be imported by modules. I am afraid it is not part
of this series, but should not be too hard once agreed how such a list
will be defined.

>> (the above would basically break virtualbox, which I knows uses preempt
>> notifiers too, but I don't give a rats arse about that)
>
>It's a huge red flag for anyone reviewing the code that this module is
>doing something it probably really should not be doing at all.  It will
>make reviewing code easier, this isn't there to try to "prevent bad
>actors" at all, sorry.
>

Cheers,
Matthias
