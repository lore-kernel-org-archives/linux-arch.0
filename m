From: "H. Peter Anvin" <hpa@linux.intel.com>
Subject: Re: [PATCH 1/1] x86: Fix warning: ignoring return value of 'fread'
Date: Wed, 25 Aug 2010 17:12:59 -0700
Message-ID: <4C75B18B.5070803@linux.intel.com>
References: <20100826000959.GA7220@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:51319 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752574Ab0HZANL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 25 Aug 2010 20:13:11 -0400
In-Reply-To: <20100826000959.GA7220@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jean Sacren <sakiwit@gmail.com>
Cc: Linux Arch Mailing List <linux-arch@vger.kernel.org>

On 08/25/2010 05:09 PM, Jean Sacren wrote:
> warning: ignoring return value of 'fread', declared with attribute
> warn_unused_result
> 
> This fix facilitates fread() either it succeeds, or an error occurs or
> the end of file is reached.
> 
> Signed-off-by: Jean Sacren <sakiwit@gmail.com>
> ---
>  arch/x86/boot/compressed/mkpiggy.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/mkpiggy.c b/arch/x86/boot/compressed/mkpiggy.c
> index 5c22812..fac37c3 100644
> --- a/arch/x86/boot/compressed/mkpiggy.c
> +++ b/arch/x86/boot/compressed/mkpiggy.c
> @@ -62,7 +62,10 @@ int main(int argc, char *argv[])
>  	if (fseek(f, -4L, SEEK_END)) {
>  		perror(argv[1]);
>  	}
> -	fread(&olen, sizeof olen, 1, f);
> +
> +	if (fread(&olen, sizeof olen, 1, f) < 1)
> +		fprintf(stderr, "\nError in reading or end of file.\n");
> +
>  	ilen = ftell(f);
>  	olen = getle32(&olen);
>  	fclose(f);

I usually prefer the style:

if (fread(&olen, 1, sizeof olen, f) != sizeof olen)

... for consistency with plain write().  It's a minor nitpick, though.

	-hpa
