From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Turn CONFIG_STRICT_DEVMEM in sysctl
	dev.mem.restricted
Date: Sun, 16 Nov 2008 16:09:05 +0000
Message-ID: <20081116160905.17e867da@lxorguk.ukuu.org.uk>
References: <1226846868-9595-1-git-send-email-bwalle@suse.de>
	<20081116150756.3cece2de@lxorguk.ukuu.org.uk>
	<20081116162003.04267538@kopernikus.site>
	<20081116154541.1f196f1e@lxorguk.ukuu.org.uk>
	<20081116080342.3d6c6976@infradead.org>
Reply-To: "Discussion list for crash utility usage,
	maintenance and development" <crash-utility@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <crash-utility-bounces@redhat.com>
In-Reply-To: <20081116080342.3d6c6976@infradead.org>
List-Unsubscribe: <https://www.redhat.com/mailman/listinfo/crash-utility>,
	<mailto:crash-utility-request@redhat.com?subject=unsubscribe>
List-Archive: <https://www.redhat.com/archives/crash-utility>
List-Post: <mailto:crash-utility@redhat.com>
List-Help: <mailto:crash-utility-request@redhat.com?subject=help>
List-Subscribe: <https://www.redhat.com/mailman/listinfo/crash-utility>,
	<mailto:crash-utility-request@redhat.com?subject=subscribe>
Sender: crash-utility-bounces@redhat.com
Errors-To: crash-utility-bounces@redhat.com
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-arch@vger.kernel.org, Bernhard Walle <bwalle@suse.de>, x86@kernel.org, linux-kernel@vger.kernel.org, crash-utility@redhat.com
List-Id: linux-arch.vger.kernel.org

> because it can load kernel modules?
> or because it can bypass the iommu?

It has iopl, firmware loading, ioperm, raw disk I/O, mknod, module loading
etc etc.. 

> the point of the /dev/mem restrictions is to not allow things you know
> you don't need, while still allowing X to function where it can access
> the crap it does. Now in Bernhard's case he DOES need them, so he
> shouldn't use the restrictions.

I know what the point is, but it doesn't actually implement any
meaningful restriction to achieve that result, so it is worthless junk.

> > There are proper ways to deal with X, modern video cards and modern
> > security models. They involve using framebuffer mappings off the PCI
> > device node itself and DRI.
> > 
> when X has this for all hw that matters /dev/mem could go away for the
> people who then no longer have any need for it.

Why should it go away ? It's a matter of file permissions and security
rules as to who can access it. Trying to make it go away is just more
fake-security crap.

Alan
