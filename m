Return-Path: <davem@redhat.com>
Received: from mx1.redhat.com ([66.187.233.31]:60580 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262441AbUDAHSO (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 1 Apr 2004 02:18:14 -0500
Date: Wed, 31 Mar 2004 23:17:31 -0800
From: "David S. Miller" <davem@redhat.com>
Subject: Re: generalize/fix wchan calculation via ELF sections
Message-Id: <20040331231731.2bd7889d.davem@redhat.com>
In-Reply-To: <20040331073539.GX791@holomorphy.com>
References: <20040331073539.GX791@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


I like this patch.  If Sparc explodes, we'll fix it whenever Linus
sucks it in.
