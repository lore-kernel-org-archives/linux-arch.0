From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [RFC] get_write_access()/deny_write_access() without
 inode->i_lock
Date: Mon, 20 Jun 2011 14:18:18 +0100
Message-ID: <20110620131818.GR11521@ZenIV.linux.org.uk>
References: <20110619235147.GQ11521@ZenIV.linux.org.uk>
 <21839.1308574037@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <21839.1308574037@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org

On Mon, Jun 20, 2011 at 01:47:17PM +0100, David Howells wrote:
> Al Viro <viro@ZenIV.linux.org.uk> wrote:
> 
> > +	for (v = atomic_read(&inode->i_writecount); v >= 0; v = v1) {
> > +		v1 = atomic_cmpxchg(&inode->i_writecount, v, v + 1);
> > +		if (likely(v1 == v))
> > +			return 0;
> > +	}
> 
> You don't need to reissue the atomic_read().  atomic_cmpxchg() returns the
> current value of the memory location.  Just set v to v1 before going round the
> loop again.

That's precisely what that loop is doing...
