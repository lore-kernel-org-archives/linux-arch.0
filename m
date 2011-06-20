From: David Howells <dhowells@redhat.com>
Subject: Re: [RFC] get_write_access()/deny_write_access() without inode->i_lock
Date: Mon, 20 Jun 2011 14:20:34 +0100
Message-ID: <22606.1308576034@redhat.com>
References: <21839.1308574037@redhat.com> <20110619235147.GQ11521@ZenIV.linux.org.uk>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <21839.1308574037@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Cc: dhowells@redhat.com, Al Viro <viro@ZenIV.linux.org.uk>, linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org

David Howells <dhowells@redhat.com> wrote:

> > +	for (v = atomic_read(&inode->i_writecount); v >= 0; v = v1) {
> > +		v1 = atomic_cmpxchg(&inode->i_writecount, v, v + 1);
> > +		if (likely(v1 == v))
> > +			return 0;
> > +	}
> 
> You don't need to reissue the atomic_read().  atomic_cmpxchg() returns the
> current value of the memory location.  Just set v to v1 before going round the
> loop again.

Ah...  Never mind - you did that anyway.

David
