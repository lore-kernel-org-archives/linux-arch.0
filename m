From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] locking/qrwlock: fix write unlock issue in big endian
Date: Wed, 8 Jun 2016 10:22:44 +0100
Message-ID: <20160608092244.GA27029@arm.com>
References: <1464862148-5672-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1464862148-5672-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de, waiman.long@hp.com, peterz@infradead.org
List-Id: linux-arch.vger.kernel.org

On Thu, Jun 02, 2016 at 06:09:08PM +0800, Pan Xinhui wrote:
> strcut __qrwlock has different layout in big endian machine. we need set
> the __qrwlock->wmode to NULL, and the address is not &lock->cnts in big
> endian machine.
> 
> Do as what read unlock does. we are lucky that the __qrwlock->wmode's
> val is _QW_LOCKED.

Doesn't this have wider implications for the qrwlocks, for example:

  while ((cnts & _QW_WMASK) == _QW_LOCKED) { ... }

would actually end up looking at the wrong field of the lock?

Shouldn't we just remove the #ifdef __LITTLE_ENDIAN stuff from __qrwlock,
given that all the struct members are u8?

Will
