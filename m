Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268095AbUI1WXh@vger.kernel.org>
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:19082
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S268074AbUI1WWf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 28 Sep 2004 18:22:35 -0400
Date: Tue, 28 Sep 2004 15:22:10 -0700
From: "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] ppc64: Fix 32 bits conversion of SI_TIMER signals
Message-Id: <20040928152210.1550b3c3.davem@davemloft.net>
In-Reply-To: <1096181913.18234.300.camel@gaston>
References: <200409260205.i8Q25pGb013827@hera.kernel.org>
	<1096181913.18234.300.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


Ben, have you taken a quick look to see if any other
platforms doing compat stuff need a fix like this as
well?  If not, could you do so real quick?  Thanks.
