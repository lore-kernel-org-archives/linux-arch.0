From: Nicolas Pitre <nico-vtqb6HGKxmzR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH v3 00/11] Symbol Namespaces
Date: Wed, 21 Aug 2019 16:48:10 -0400 (EDT)
Message-ID: <nycvar.YSQ.7.76.1908211642050.19480@knanqh.ubzr>
References: <20190813121733.52480-1-maennich@google.com>
 <20190821114955.12788-1-maennich@google.com>
 <nycvar.YSQ.7.76.1908210840490.19480@knanqh.ubzr>
 <20190821133737.GB4890@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20190821133737.GB4890-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
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
Cc: kstewart-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, oneukum-IBi9RG/b67k@public.gmane.org, linux-aspeed-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, usb-storage-ijkIwGHArpdIPJnuZ7Njw4oP9KaGy4wf@public.gmane.org, Toru Komatsu <k0ma-h7Lmzv2voGl4Eiagz67IpQ@public.gmane.org>, Mauro Carvalho Chehab <mchehab+samsung-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Nicolas Ferre <nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>, David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org, Will Deacon <will-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, patches-yzvPICuk2AA4QjBA90+/kJqQE7yCjDx5@public.gmane.org, Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>, hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org, joel-QYYGw3jwrUn5owFQY34kdNi2O/JbrIOy@public.gmane.org, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org, cocci-/FJkirnvOdkvYVN+rsErww@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Benjamin Fair <benjaminfair-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, linux-scsi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, openbmc-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lucas.de.marchi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Nancy Yuen <yuenn-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org, NXP Linux Team <linux-imx-3arQi8VN3Tc@public.gmane.org>, Johan
List-Id: linux-arch.vger.kernel.org

On Wed, 21 Aug 2019, Greg KH wrote:

> On Wed, Aug 21, 2019 at 08:46:47AM -0400, Nicolas Pitre wrote:
> 
> > One solution for drastically reducing the effective export surface is to 
> > have CONFIG_TRIM_UNUSED_KSYMS=y. This is more extreme than symbol 
> > namespace, but might be worth mentioning nevertheless.
> 
> Oh that's amazing, I never noticed that feature.  That is a nice thing,
> thanks for pointing it out.

For those interested, this feature was demonstrated with numbers here:

https://lwn.net/Articles/746780/


Nicolas
