From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [Xen-devel] [PATCH 3/8] x86/xen/p2m: Replace ACCESS_ONCE with
 READ_ONCE
Date: Thu, 15 Jan 2015 12:07:11 +0100
Message-ID: <54B79F5F.1040806@de.ibm.com>
References: <1421312314-72330-1-git-send-email-borntraeger@de.ibm.com> <1421312314-72330-4-git-send-email-borntraeger@de.ibm.com> <54B799DC.1050008@citrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <54B799DC.1050008@citrix.com>
Sender: owner-linux-mm@kvack.org
To: David Vrabel <david.vrabel@citrix.com>, linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, kvm@vger.kernel.org, x86@kernel.org, kvm-ppc@vger.kernel.org, linux-mm@kvack.org, xen-devel@lists.xenproject.org, linuxppc-dev@lists.ozlabs.org
List-Id: linux-arch.vger.kernel.org

Am 15.01.2015 um 11:43 schrieb David Vrabel:
> On 15/01/15 08:58, Christian Borntraeger wrote:
>> ACCESS_ONCE does not work reliably on non-scalar types. For
>> example gcc 4.6 and 4.7 might remove the volatile tag for such
>> accesses during the SRA (scalar replacement of aggregates) step
>> (https://gcc.gnu.org/bugzilla/show_bug.cgi?id=58145)
>>
>> Change the p2m code to replace ACCESS_ONCE with READ_ONCE.
> 
> Acked-by: David Vrabel <david.vrabel@citrix.com>

Thanks

> Let me know if you want me to merge this via the Xen tree.


With your Acked-by, I can easily carry this in my tree. We can 
then ensure that this patch is merged before the ACCESS_ONCE is
made stricter - making bisecting easier.

Christian

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
