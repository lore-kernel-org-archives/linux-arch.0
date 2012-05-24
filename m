From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 3/3] lib: Sparc's strncpy_from_user is generic enough, move under lib/
Date: Thu, 24 May 2012 18:17:52 +0100
Message-ID: <14863.1337879872@redhat.com>
References: <20120523.233440.1152363385537335796.davem@davemloft.net>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:9198 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932167Ab2EXRR6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 24 May 2012 13:17:58 -0400
In-Reply-To: <20120523.233440.1152363385537335796.davem@davemloft.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: dhowells@redhat.com, linux-arch@vger.kernel.org, torvalds@linux-foundation.org

David Miller <davem@davemloft.net> wrote:

> To use this, an architecture simply needs to:
> 
> 1) Provide a user_addr_max() implementation via asm/uaccess.h
> 
> 2) Add "select GENERIC_STRNCPY_FROM_USER" to their arch Kcnfig
> 
> 3) Remove the existing strncpy_from_user() implementation and symbol
>    exports their architecture had.
> 
> Signed-off-by: David S. Miller <davem@davemloft.net>

Contingent on removing the extraneous semicolon:

Acked-by: David Howells <dhowells@redhat.com>
