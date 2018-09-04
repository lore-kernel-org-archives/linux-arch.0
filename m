Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:50794 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726015AbeIDU3c (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 4 Sep 2018 16:29:32 -0400
Date: Tue, 4 Sep 2018 18:03:10 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v5 07/16] x86/pci: add Hygon PCI vendor and northbridge
 support
Message-ID: <20180904160310.GJ32615@zn.tnic>
References: <cover.1535459012.git.puwen@hygon.cn>
 <ecd62b5b5e8f406598f2354892929caa87cf7deb.1535459013.git.puwen@hygon.cn>
 <20180904145255.GI32615@zn.tnic>
 <5c6b1493-ee20-ed3f-a558-331c0cb65556@hygon.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5c6b1493-ee20-ed3f-a558-331c0cb65556@hygon.cn>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Pu Wen <puwen@hygon.cn>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com, pbonzini@redhat.com, helgaas@kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-pci@vger.kernel.org
Message-ID: <20180904160310.5-uGjdoPbOn2ZlJO5N5OFXSV-hqAGRVUU1ab63bap-k@z>

On Tue, Sep 04, 2018 at 11:45:02PM +0800, Pu Wen wrote:
> I add these definitions to indicate that there are Hygon PCI device IDs.
> You are right, I can just use the AMD f17h ones here.

Right, if this is a small piece where they're all together in a single
compilation unit - like in this case - I don't see an issue with using
the AMD ones. Later, when you start splitting functionality, you can do
proper defines.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
