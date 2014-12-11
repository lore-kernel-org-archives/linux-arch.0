From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH RFC 3/5] pci: add pci_iomap_range
Date: Thu, 11 Dec 2014 23:27:54 +0100
Message-ID: <11102634.nzYXXfUH5X@wuerfel>
References: <1418326570-9541-1-git-send-email-mst@redhat.com>
	<1418326570-9541-4-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1418326570-9541-4-git-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: linux-arch.vger.kernel.org

On Thursday 11 December 2014 21:37:34 Michael S. Tsirkin wrote:
>         if (flags & IORESOURCE_MEM) {
> -               if (flags & IORESOURCE_CACHEABLE)
> +               if (!force_nocache && (flags & IORESOURCE_CACHEABLE))
>                         return ioremap(start, len);
>                 return ioremap_nocache(start, len);
>         }
> 

ioremap is the same as ioremap_nocache, so this doesn't really make any
sense. IORESOURCE_CACHEABLE is practically only set for ROM bars, which
we rarely map.

	Arnd
