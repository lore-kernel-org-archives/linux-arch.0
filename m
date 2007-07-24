Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from gw.goop.org ([64.81.55.164]:51118 "EHLO mail.goop.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753207AbXGXS7j (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 24 Jul 2007 14:59:39 -0400
Message-ID: <46A64BDD.4080309@goop.org>
Date: Tue, 24 Jul 2007 11:58:37 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
MIME-Version: 1.0
Subject: Re: [PATCH][RFC] getting rid of stupid loop in BUG()
References: <20070724153916.GS21668@ftp.linux.org.uk> <46A62F35.2000501@goop.org> <20070724171455.GT21668@ftp.linux.org.uk> <46A636BB.7020706@zytor.com>
In-Reply-To: <46A636BB.7020706@zytor.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Al Viro <viro@ftp.linux.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

H. Peter Anvin wrote:
> Could it be a gcc version difference?
>   

Likely.  Well, we can always try it and see how much crap turns up.  If
gcc keeps quiet about it, its certainly an improvement over the dummy loop.

    J
