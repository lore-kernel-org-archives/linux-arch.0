From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v6 40/53] PCI: Unify skip_ioresource_align()
Date: Thu, 1 Oct 2015 10:17:03 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1510011016500.4500@nanos>
References: <1443678807-786-1-git-send-email-yinghai@kernel.org> <1443678807-786-41-git-send-email-yinghai@kernel.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1443678807-786-41-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, David Miller <davem@davemloft.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>, Yijing Wang <wangyijing@huawei.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Michal Simek <monstr@monstr.eu>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Wed, 30 Sep 2015, Yinghai Lu wrote:

> There are powerpc generic version and x86 local version for
> skip_ioresource_align().
> 
> Move the powerpc version to setup-bus.c, and kill x86 local version.
> 
> Also kill dummy version in microblaze.
> 
> Cc: Michal Simek <monstr@monstr.eu>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-arch@vger.kernel.org
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
