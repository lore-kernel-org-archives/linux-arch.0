Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Thu, 16 Jun 2005 21:45:39 -0700 (PDT)
Message-Id: <20050616.214539.59469447.davem@davemloft.net>
Subject: Re: Global spinlock vs local bit spin locks
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <1118982092.5261.44.camel@npiggin-nld.site>
References: <1118982092.5261.44.camel@npiggin-nld.site>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: nickpiggin@yahoo.com.au
Cc: anton@samba.org, linux-arch@vger.kernel.org, akpm@osdl.org, Peter.Keilty@hp.com
List-ID: <linux-arch.vger.kernel.org>

From: Nick Piggin <nickpiggin@yahoo.com.au>
Date: Fri, 17 Jun 2005 14:21:32 +1000

> Any input would be appreciated.

I totally agree with this change.  I'm surprised that page_update_lock
lived this long :)
