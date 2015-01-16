From: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 0/8] current ACCESS_ONCE patch queue
Date: Fri, 16 Jan 2015 13:12:23 +0100
Message-ID: <54B90027.5040103@suse.de>
References: <1421312314-72330-1-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1421312314-72330-1-git-send-email-borntraeger@de.ibm.com>
Sender: owner-linux-mm@kvack.org
To: Christian Borntraeger <borntraeger@de.ibm.com>, linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org, xen-devel@lists.xenproject.org, linux-mm@kvack.org
List-Id: linux-arch.vger.kernel.org



On 15.01.15 09:58, Christian Borntraeger wrote:
> Folks,
> 
> fyi, this is my current patch queue for the next merge window. It
> does contain a patch that will disallow ACCESS_ONCE on non-scalar
> types.
> 
> The tree is part of linux-next and can be found at
> git://git.kernel.org/pub/scm/linux/kernel/git/borntraeger/linux.git linux-next

KVM PPC bits are:

 Acked-by: Alexander Graf <agraf@suse.de>



Alex

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
