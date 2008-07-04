From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 4/5] byteorder: fix direct byteswap includes
Date: Fri, 04 Jul 2008 16:37:43 +0100
Message-ID: <27042.1215185863@redhat.com>
References: <1215144734.16647.70.camel@brick>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:48594 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751922AbYGDPiX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 4 Jul 2008 11:38:23 -0400
In-Reply-To: <1215144734.16647.70.camel@brick>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Harvey Harrison <harvey.harrison@gmail.com>
Cc: dhowells@redhat.com, Andrew Morton <akpm@linux-foundation.org>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

Harvey Harrison <harvey.harrison@gmail.com> wrote:

> +#include <asm/byteorder.h>

Please use <linux/byteorder.h> rather than <asm/byteorder.h> when including
stuff from .c files outside the include and arch directories.

And whilst you're at it, Documentation/byteorder.txt is yours for the
creation:-)

David
