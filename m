Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44502 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728027AbfHNMyf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 14 Aug 2019 08:54:35 -0400
Received: by mail-wr1-f66.google.com with SMTP id p17so110969803wrf.11
        for <linux-arch@vger.kernel.org>; Wed, 14 Aug 2019 05:54:33 -0700 (PDT)
Date: Wed, 14 Aug 2019 13:54:27 +0100
From: Matthias Maennich <maennich@google.com>
Subject: Re: [PATCH v2 05/10] module: add config option
 MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS
Message-ID: <20190814125427.GA72826@google.com>
References: <20180716122125.175792-1-maco@android.com>
 <20190813121733.52480-1-maennich@google.com>
 <20190813121733.52480-6-maennich@google.com>
 <CAGETcx_LQDdnaU+3JVGw+6=DJ8tRoQ00+3rD2gOiHHkWomt8jg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAGETcx_LQDdnaU+3JVGw+6=DJ8tRoQ00+3rD2gOiHHkWomt8jg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Saravana Kannan <saravanak@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, maco@android.com, Android Kernel Team <kernel-team@android.com>, arnd@arndb.de, geert@linux-m68k.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, hpa@zytor.com, jeyu@kernel.org, "Joel Fernandes (Google)" <joel@joelfernandes.org>, kstewart@linuxfoundation.org, linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-modules@vger.kernel.org, linux-scsi@vger.kernel.org, linux-usb@vger.kernel.org, lucas.de.marchi@gmail.com, maco@google.com, michal.lkml@markovi.net, mingo@redhat.com, oneukum@suse.com, pombredanne@nexb.com, sam@ravnborg.org, Sandeep Patil <sspatil@google.com>, stern@rowland.harvard.edu, tglx@linutronix.de, usb-storage@lists.one-eyed-alien.net, x86@kernel.org, yamada.masahiro@socionext.com, Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, David Howells <dhowells@redhat.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Dan Williams <dan.j.williams@intel.com>, Adrian Reber <adrian@lisas.de>, Richard Guy Briggs <rgb@redhat.com>
Message-ID: <20190814125427.gWe2EfVF4uvq3ELCk1FbSYnHU_YJDLJX5BTsUhlu_9o@z>

On Tue, Aug 13, 2019 at 01:15:44PM -0700, Saravana Kannan wrote:
>On Tue, Aug 13, 2019 at 5:19 AM 'Matthias Maennich' via kernel-team
><kernel-team@android.com> wrote:
>>
>> If MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is enabled (default=n), the
>> requirement for modules to import all namespaces that are used by
>> the module is relaxed.
>>
>> Enabling this option effectively allows (invalid) modules to be loaded
>> while only a warning is emitted.
>>
>> Disabling this option keeps the enforcement at module loading time and
>> loading is denied if the module's imports are not satisfactory.
>>
>> Reviewed-by: Martijn Coenen <maco@android.com>
>> Signed-off-by: Matthias Maennich <maennich@google.com>
>> ---
>>  init/Kconfig    | 14 ++++++++++++++
>>  kernel/module.c | 11 +++++++++--
>>  2 files changed, 23 insertions(+), 2 deletions(-)
>>
>> diff --git a/init/Kconfig b/init/Kconfig
>> index bd7d650d4a99..b3373334cdf1 100644
>> --- a/init/Kconfig
>> +++ b/init/Kconfig
>> @@ -2119,6 +2119,20 @@ config MODULE_COMPRESS_XZ
>>
>>  endchoice
>>
>> +config MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS
>> +       bool "Allow loading of modules with missing namespace imports"
>> +       default n
>> +       help
>> +         Symbols exported with EXPORT_SYMBOL_NS*() are considered exported in
>> +         a namespace. A module that makes use of a symbol exported with such a
>> +         namespace is required to import the namespace via MODULE_IMPORT_NS().
>> +         This option relaxes this requirement when loading a module.
>
>> While
>> +         technically there is no reason to enforce correct namespace imports,
>> +         it creates consistency between symbols defining namespaces and users
>> +         importing namespaces they make use of.
>
>I'm confused by this sentence. It sounds like it's the opposite of
>what the config is doing? Can you please reword it for clarify?

How about:

  Symbols exported with EXPORT_SYMBOL_NS*() are considered exported in
  a namespace. A module that makes use of a symbol exported with such a
  namespace is required to import the namespace via MODULE_IMPORT_NS().
  There is no technical reason to enforce correct namespace imports,
  but it creates consistency between symbols defining namespaces and
  users importing namespaces they make use of. This option relaxes this
  requirement and lifts the enforcement when loading a module.

-- 
Cheers,
Matthias
