From: Matthew Wilcox <willy@infradead.org>
Subject: Re: memfill
Date: Tue, 7 Feb 2017 11:03:57 -0800
Message-ID: <20170207190357.GN2267@bombadil.infradead.org>
References: <20170207172258.GM2267@bombadil.infradead.org>
 <20170206144902.GH2267@bombadil.infradead.org>
 <1486307804-27903-1-git-send-email-minchan@kernel.org>
 <27995.1486460404@warthog.procyon.org.uk>
 <28294.1486488555@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <28294.1486488555@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: Minchan Kim <minchan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, sergey.senozhatsky@gmail.com, iamjoonsoo.kim@lge.com, ngupta@vflare.org, zhouxianrong@huawei.com, zhouxiyu@huawei.com, weidu.du@huawei.com, zhangshiming5@huawei.com, Mi.Sophia.Wang@huawei.com, won.ho.park@huawei.com
List-Id: linux-arch.vger.kernel.org

On Tue, Feb 07, 2017 at 05:29:15PM +0000, David Howells wrote:
> Matthew Wilcox <willy@infradead.org> wrote:
> 
> > You've misunderstood the purpose of memfill.  memfill allows the caller
> > to specify a pattern which is not a single byte in size, eg memfill(addr,
> > 0x12345678, 64) would result in 0x12345678 being reproduced 16 times.
> > memset(addr, 0x12345678, 64) would result in 0x78 being reproduced
> > 64 times.
> 
> Ah.  Should it take a unsigned int rather than an unsigned long?

Well, our one user so far is looking to use an unsigned long (indeed,
wouldn't be able to use it if it took an unsigned int).  If we have users
who want to memfill with an unsigned int, they can do something like:

void memfill_int(int *a, unsigned int v, size_t n)
{
	if ((unsigned long)a & (sizeof(unsigned long) - 1)) {
		*a++ = v;
		n -= sizeof(unsigned int);
	}
	memfill((unsigned long *)a, v | ((v << 16) << 16), n);
	if (n & (sizeof(unsigned long) - 1)
		a[n / sizeof(v)] = v;
}

... but since we know of no users today, I don't want to put that in.
