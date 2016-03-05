From: "Elliott, Robert (Persistent Memory)" <elliott@hpe.com>
Subject: RE: [PATCH v2] x86: PAT: Documentation: rewrite "MTRR effects on
 PAT / non-PAT systems"
Date: Sat, 5 Mar 2016 04:39:58 +0000
Message-ID: <94D0CD8314A33A4D9D801C0FE68B40295C350C7C@G9W0745.americas.hpqcorp.net>
References: <20160304210900.GT3577@linux.vnet.ibm.com>
 <1457131501-14855-1-git-send-email-mcgrof@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from g9t5009.houston.hp.com ([15.240.92.67]:40953 "EHLO
	g9t5009.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759763AbcCEEkZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 4 Mar 2016 23:40:25 -0500
In-Reply-To: <1457131501-14855-1-git-send-email-mcgrof@kernel.org>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>, "paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>, "bp@alien8.de" <bp@alien8.de>, "mingo@kernel.org" <mingo@kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "hpa@zytor.com" <hpa@zytor.com>, "toshi.kani@hp.com" <toshi.kani@hp.com>
Cc: "airlied@redhat.com" <airlied@redhat.com>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>, "mst@redhat.com" <mst@redhat.com>, "vinod.koul@intel.com" <vinod.koul@intel.com>, "jgross@suse.com" <jgross@suse.com>, "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>, "luto@amacapital.net" <luto@amacapital.net>, "davem@davemloft.net" <davem@davemloft.net>, "ben@decadent.org.uk" <ben@decadent.org.uk>, "benjamin.poirier@gmail.com" <benjamin.poirier@gmail.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "corbet@lwn.net" <corbet@lwn.net>

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
> owner@vger.kernel.org] On Behalf Of Luis R. Rodriguez
> Sent: Friday, March 04, 2016 4:45 PM
> Subject: [PATCH v2] x86: PAT: Documentation: rewrite "MTRR effects on
> PAT / non-PAT systems"
...
> +MMIO and another PCI BAR for write-combing, if needed.

typo: combining
