From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 04/16] dyndbg: rename __verbose section to __dyndbg
Date: Wed, 27 Nov 2019 12:42:12 -0800
Message-ID: <80168e5bebedeb64e999ed11d8479846270bd3d7.camel@perches.com>
References: <20191127175051.1351346-1-jim.cromie@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191127175051.1351346-1-jim.cromie@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jim Cromie <jim.cromie@gmail.com>, jbaron@akamai.com, linux-kernel@vger.kernel.org
Cc: linux@rasmusvillemoes.dk, greg@kroah.com, Arnd Bergmann <arnd@arndb.de>, Jessica Yu <jeyu@kernel.org>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Wed, 2019-11-27 at 10:50 -0700, Jim Cromie wrote:
> dyndbg populates its callsite info into __verbose section, change that
> to a more specific and descriptive name, __dyndbg.
[]
> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
[]
> @@ -1040,7 +1040,7 @@ static int __init dynamic_debug_init(void)
>  	ddebug_init_success = 1;
>  	vpr_info("%d modules, %d entries and %d bytes in ddebug tables, %d bytes in (readonly) verbose section\n",

This format should also change verbose to dyndbg
Maybe the ddebug word too

>  		 modct, entries, (int)(modct * sizeof(struct ddebug_table)),
> -		 verbose_bytes + (int)(__stop___verbose - __start___verbose));
> +		 verbose_bytes + (int)(__stop___dyndbg - __start___dyndbg));
>  
>  	/* apply ddebug_query boot param, dont unload tables on err */
>  	if (ddebug_setup_string[0] != '\0') {
