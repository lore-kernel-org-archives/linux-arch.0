Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268457AbUHLAwr@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:5589 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268389AbUHLAY6 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 11 Aug 2004 20:24:58 -0400
Date: Wed, 11 Aug 2004 17:24:12 -0700
From: "David S. Miller" <davem@redhat.com>
Subject: Re: clear_user_highpage()
Message-Id: <20040811172412.581fd406.davem@redhat.com>
In-Reply-To: <1092269196.2166.34.camel@gaston>
References: <20040811161537.5e24c2b6.davem@redhat.com>
	<Pine.LNX.4.58.0408111635160.1839@ppc970.osdl.org>
	<20040811165307.46ff1eb6.davem@redhat.com>
	<Pine.LNX.4.58.0408111654440.1839@ppc970.osdl.org>
	<1092269196.2166.34.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: torvalds@osdl.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Thu, 12 Aug 2004 10:06:37 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> Ok, that may be why it was removed from ppc then, I should ask Paul.

I think this might have more to do with the fact that they
got tired locally patching their tree all the time.  It required
changes to generic code which they could never get merged
upstream.
