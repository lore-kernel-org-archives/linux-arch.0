From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [PATCH v2 00/29] Create PCI root buses with correct resources
Date: Fri, 14 Oct 2011 10:14:14 -0500
Message-ID: <1318605254.3018.20.camel@dabdike.int.hansenpartnership.com>
References: <20111014042142.23504.70417.stgit@bhelgaas.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20111014042142.23504.70417.stgit@bhelgaas.mtv.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Thu, 2011-10-13 at 22:27 -0600, Bjorn Helgaas wrote:
> The most generic way to create a PCI root bus is with pci_scan_bus(), but
> that doesn't allow you to specify what resources are available on the bus,
> i.e., what the host bridge apertures are.

Do you have an actual tree for this?  The PARISC pieces look a bit
non-trivial and I'd like to test them out on the various sba/astro/dino
systems.

James
