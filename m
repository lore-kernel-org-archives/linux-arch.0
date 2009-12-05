From: David Miller <davem@davemloft.net>
Subject: Re: [RFC][PATCH 17/18] sparc_brk() is not needed anymore
Date: Sat, 05 Dec 2009 15:11:19 -0800 (PST)
Message-ID: <20091205.151119.76763870.davem@davemloft.net>
References: <E1NGzzv-0008Rx-51@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932871AbZLEXL3@vger.kernel.org>
In-Reply-To: <E1NGzzv-0008Rx-51@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: viro@ftp.linux.org.uk
Cc: linux-arch@vger.kernel.org, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

From: Al Viro <viro@ftp.linux.org.uk>
Date: Sat, 05 Dec 2009 19:08:51 +0000

> 
> the checks it's doing are duplicated in sys_brk() and failing
> them early makes no sense, AFAICT.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Acked-by: David S. Miller <davem@davemloft.net>
