From: Gleb Natapov <gleb@redhat.com>
Subject: Re: [PATCH 1/1] KVM: add kvm_para_available to asm-generic/kvm_para.h
Date: Tue, 4 Jun 2013 12:05:08 +0300
Message-ID: <20130604090508.GL4725@redhat.com>
References: <1369222162-4857-1-git-send-email-james.hogan@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1369222162-4857-1-git-send-email-james.hogan@imgtec.com>
Sender: linux-kernel-owner@vger.kernel.org
To: James Hogan <james.hogan@imgtec.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Marcelo Tosatti <mtosatti@redhat.com>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-arch.vger.kernel.org

On Wed, May 22, 2013 at 12:29:22PM +0100, James Hogan wrote:
> According to include/uapi/linux/kvm_para.h architectures should define
> kvm_para_available, so add an implementation to asm-generic/kvm_para.h
> which just returns false.
> 
What is this fixing? The only user of kvm_para_available() that can
benefit from this is in sound/pci/intel8x0.c, but I do not see follow up
patch to use it there.

> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Marcelo Tosatti <mtosatti@redhat.com>
> Cc: Gleb Natapov <gleb@redhat.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> ---
>  include/asm-generic/kvm_para.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/include/asm-generic/kvm_para.h b/include/asm-generic/kvm_para.h
> index 9d96605..fa25bec 100644
> --- a/include/asm-generic/kvm_para.h
> +++ b/include/asm-generic/kvm_para.h
> @@ -18,4 +18,9 @@ static inline unsigned int kvm_arch_para_features(void)
>  	return 0;
>  }
>  
> +static inline bool kvm_para_available(void)
> +{
> +	return false;
> +}
> +
>  #endif
> -- 
> 1.8.1.2
> 

--
			Gleb.
