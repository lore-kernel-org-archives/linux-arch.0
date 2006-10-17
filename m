Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:56457 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1423186AbWJQJEl (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 17 Oct 2006 05:04:41 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20061017005025.GF29920@ftp.linux.org.uk> 
References: <20061017005025.GF29920@ftp.linux.org.uk> 
Subject: Re: [RFC] typechecking for get_unaligned/put_unaligned 
Date: Tue, 17 Oct 2006 10:04:00 +0100
Message-ID: <27543.1161075840@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Al Viro <viro@ftp.linux.org.uk> wrote:

> 	* sizeof(*ptr) should be one of 1, 2, 4, 8

Should we give an error if someone tries passing a 1-byte-sized memory location
to get/put_unaligned()?  I suspect it might be best to reduce to a trivial
direct assignment in that case.

David
