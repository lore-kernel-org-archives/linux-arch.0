Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org ([203.10.76.45]:12984 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S264346AbUFDAdZ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 3 Jun 2004 20:33:25 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16575.50024.908291.283284@cargo.ozlabs.ibm.com>
Date: Fri, 4 Jun 2004 10:33:44 +1000
From: Paul Mackerras <paulus@samba.org>
Subject: Re: FUTEX_CMP_REQUEUE and 6-argument syscall
In-Reply-To: <20040603110221.1fe58b53.zaitcev@redhat.com>
References: <20040603110221.1fe58b53.zaitcev@redhat.com>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: schwidefsky@de.ibm.com, linux-arch@vger.kernel.org, akpm@osdl.org, jakub@redhat.com
List-ID: <linux-arch.vger.kernel.org>

Pete Zaitcev writes:

> I'm curious if any other architecture was caught out by this.

Six is currently the limit on ppc and ppc64.  It would be possible to
increase it to 7 fairly easily or 8 with a bit more trouble.  Beyond
that we would start getting arguments on the stack.

Paul.
