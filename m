From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 02/37] powerpc: use get/put_endian helpers
Date: Fri, 30 May 2008 13:33:45 +1000
Message-ID: <18495.30105.514217.282841@cargo.ozlabs.ibm.com>
References: <1212092275.28403.104.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:48997 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752139AbYE3Dvw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 29 May 2008 23:51:52 -0400
In-Reply-To: <1212092275.28403.104.camel@brick>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Harvey Harrison <harvey.harrison@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-arch <linux-arch@vger.kernel.org>

Harvey Harrison writes:

> Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
> ---

Somewhere in this series of patches there should be a patch
description that tells us why we're making all these changes.  I don't
know what the motivation for them is and I don't see it spelled out
anywhere.  If/when these patches go into git there needs to be at
least one of the commits whose description records the motivation for
posterity.

Paul.
