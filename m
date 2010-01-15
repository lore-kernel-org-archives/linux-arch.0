From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH 1/2] resource: align functions now return start of
 resource
Date: Fri, 15 Jan 2010 10:23:37 -0800
Message-ID: <20100115102337.43c47b02@jbarnes-piketon>
References: <20100101163811.GA8124@comet.dominikbrodowski.net>
	<1262364050-8540-1-git-send-email-linux@dominikbrodowski.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1262364050-8540-1-git-send-email-linux@dominikbrodowski.net>
Sender: linux-pci-owner@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, torvalds@linux-foundation.org, Dominik Brodowski <linux@dominikbrodowski.net>, Bjorn Helgaas <bjorn.helgaas@hp.com>, Yinghai Lu <yhlu.kernel@gmail.com>
List-Id: linux-arch.vger.kernel.org

On Fri,  1 Jan 2010 17:40:49 +0100
Dominik Brodowski <linux@dominikbrodowski.net> wrote:

> As suggested by Linus, align functions should return the start
> of a resource, not void. An update of "res->start" is no longer
> necessary.

Applied these two to my linux-next branch, thanks Dominik.

-- 
Jesse Barnes, Intel Open Source Technology Center
