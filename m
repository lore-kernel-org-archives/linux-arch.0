Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:60197
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1753008AbYDYAoL (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 24 Apr 2008 20:44:11 -0400
Date: Thu, 24 Apr 2008 17:44:10 -0700 (PDT)
Message-ID: <20080424.174410.90684218.davem@davemloft.net>
Subject: Re: [PATCH 19/24] sparc64: types: use <asm-generic/int-*.h> for
 the sparc64 architecture
From: David Miller <davem@davemloft.net>
In-Reply-To: <1209078352-7593-38-git-send-email-hpa@zytor.com>
References: <1209078352-7593-36-git-send-email-hpa@zytor.com>
	<1209078352-7593-37-git-send-email-hpa@zytor.com>
	<1209078352-7593-38-git-send-email-hpa@zytor.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: hpa@zytor.com
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20080425004410.r8VeN1zheXN_DkQfB_aSzjIgPWNWxWmUcHBhHXqQieA@z>

From: "H. Peter Anvin" <hpa@zytor.com>
Date: Thu, 24 Apr 2008 16:05:44 -0700

> This modifies <asm-sparc64/types.h> to use the <asm-generic/int-*.h>
> generic include files.
> 
> Signed-off-by: H. Peter Anvin <hpa@zytor.com>

Acked-by: David S. Miller <davem@davemloft.net>
