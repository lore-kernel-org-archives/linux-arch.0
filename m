Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Tue, 21 Jun 2005 22:46:45 -0700 (PDT)
Message-Id: <20050621.224645.78710941.davem@davemloft.net>
Subject: Re: sparsemem patches in -mm
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050621021352.46fc3b81.akpm@osdl.org>
References: <20050621021352.46fc3b81.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: akpm@osdl.org
Cc: linux-arch@vger.kernel.org, apw@shadowen.org, haveblue@us.ibm.com, matthew.e.tolentino@intel.com, bob.picco@hp.com
List-ID: <linux-arch.vger.kernel.org>

From: Andrew Morton <akpm@osdl.org>
Date: Tue, 21 Jun 2005 02:13:52 -0700

> http://www.zip.com.au/~akpm/linux/patches/stuff/sparsemem/

The only thing that sticks out to me in this patch is that
sparc64 uses a field starting at bit 24 in page->flags to
determine the cpu which needs a D-cache flush for a page.

I don't think the page->flags rework makes things any different
than before, but it's something to keep in mind.
