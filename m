From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 3/3] lib: Sparc's strncpy_from_user is generic enough, move under lib/
Date: Thu, 24 May 2012 17:10:48 +0100
Message-ID: <7607.1337875848@redhat.com>
References: <20120523.233440.1152363385537335796.davem@davemloft.net>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58440 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753139Ab2EXQKy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 24 May 2012 12:10:54 -0400
In-Reply-To: <20120523.233440.1152363385537335796.davem@davemloft.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: dhowells@redhat.com, linux-arch@vger.kernel.org, torvalds@linux-foundation.org

David Miller <davem@davemloft.net> wrote:

> +			v = (c & low_bits) + low_bits;;

You've an extra semicolon there.

David
