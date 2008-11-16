From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 3/3] Remove CONFIG_STRICT_DEVMEM
Date: Sun, 16 Nov 2008 15:09:01 +0000
Message-ID: <20081116150901.4d824e6d@lxorguk.ukuu.org.uk>
References: <1226846868-9595-1-git-send-email-bwalle@suse.de>
	<1226846868-9595-4-git-send-email-bwalle@suse.de>
Reply-To: "Discussion list for crash utility usage,
	maintenance and development" <crash-utility@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <crash-utility-bounces@redhat.com>
In-Reply-To: <1226846868-9595-4-git-send-email-bwalle@suse.de>
List-Unsubscribe: <https://www.redhat.com/mailman/listinfo/crash-utility>,
	<mailto:crash-utility-request@redhat.com?subject=unsubscribe>
List-Archive: <https://www.redhat.com/archives/crash-utility>
List-Post: <mailto:crash-utility@redhat.com>
List-Help: <mailto:crash-utility-request@redhat.com?subject=help>
List-Subscribe: <https://www.redhat.com/mailman/listinfo/crash-utility>,
	<mailto:crash-utility-request@redhat.com?subject=subscribe>
Sender: crash-utility-bounces@redhat.com
Errors-To: crash-utility-bounces@redhat.com
Cc: linux-arch@vger.kernel.org, Bernhard Walle <bwalle@suse.de>, x86@kernel.org, linux-kernel@vger.kernel.org, crash-utility@redhat.com
List-Id: linux-arch.vger.kernel.org

> -#ifdef CONFIG_STRICT_DEVMEM
> -
>  int devmem_restricted = 1;
>  
> -#if defined(CONFIG_SYSCTL) && defined(CONFIG_STRICT_DEVMEM)
> +#if defined(CONFIG_SYSCTL)
>  	/*
>  	 * since there is no unload function, we don't have to deregister that
>  	 * the whole lifetime of the kernel and can ignore the return value

NAK - this adds a pile of memory wasting complete crap to every kernel
including embedded systems. At least before you could turn it off now you
can't.
