From: Stuart Yoder <b08248@gmail.com>
Subject: Re: [RFC PATCH 03/11] PCI/MSI: Refactor pci_dev_msi_enabled()
Date: Tue, 5 Aug 2014 17:35:04 -0500
Message-ID: <CALRxmdB0Ltt3_G=D4i7x47pHCtCKo8RHgn-hgN+u=px22dimOA@mail.gmail.com>
References: <1406344128-27055-1-git-send-email-wangyijing@huawei.com>
	<1406344128-27055-4-git-send-email-wangyijing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1406344128-27055-4-git-send-email-wangyijing@huawei.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Yijing Wang <wangyijing@huawei.com>
Cc: linux-arch@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Paul.Mundt@huawei.com, linux-pci@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, "James E.J. Bottomley" <jejb@parisc-linux.org>, Xinwei Hu <huxinwei@huawei.com>, Hanjun Guo <guohanjun@huawei.com>, Bjorn Helgaas <bhelgaas@google.com>, Wuyun <wuyun.wu@huawei.com>, arnab.basu@freescale.com, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org

On Fri, Jul 25, 2014 at 10:08 PM, Yijing Wang <wangyijing@huawei.com> wrote:
> Pci_dev_msi_enabled() is used to check whether device
> MSI/MSIX enabled. Refactor this function  to suuport
> checking only device MSI or MSIX enabled.
>
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>

So this patch refactors things so that checks like this:
   > -       if (!dev->msi_enabled)

are moved into a function:
   > +       if (!pci_dev_msi_enabled(dev, MSI_TYPE))

Can you explain a bit more why this  needed.   Is it just cleanup?

Thanks,
Stuart
