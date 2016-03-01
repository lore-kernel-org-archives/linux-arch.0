From: Aleksey Makarov <aleksey.makarov@linaro.org>
Subject: Re: [PATCH v3 4/7] ACPI: parse DBG2 table
Date: Tue, 1 Mar 2016 19:24:20 +0300
Message-ID: <56D5C234.70305@linaro.org>
References: <1456749726-30261-1-git-send-email-aleksey.makarov@linaro.org>
 <1456749726-30261-5-git-send-email-aleksey.makarov@linaro.org>
 <56D5ABE1.7010905@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <56D5ABE1.7010905@hurleysoftware.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>, linux-acpi@vger.kernel.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Leif Lindholm <leif.lindholm@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, Al Stone <ahs3@redhat.com>, Christopher Covington <cov@codeaurora.org>, Matthias Brugger <mbrugger@suse.com>, Len Brown <lenb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org



On 03/01/2016 05:49 PM, Peter Hurley wrote:
> On 02/29/2016 04:42 AM, Aleksey Makarov wrote:
>> 'ARM Server Base Boot Requirements' [1] mentions DBG2 (Microsoft Debug
>> Port Table 2) [2] as a mandatory ACPI table that specifies debug ports.
>>
>> - Implement macros
>>
>> 	ACPI_DBG2_DECLARE(name, type, subtype, setup_fn, data_ptr)
>>
>>   that defines a handler for the port of given type and subtype.
>>
>> - For each declared port that is also described in the ACPI DBG2 table
>>   call the provided callback.
> 
> On 02/22/2016 06:43 AM, Aleksey Makarov wrote:
>> On 02/19/2016 08:20 PM, Christopher Covington wrote:
>>> Can the device specified in DBG2 be used for both earlycon and KGDB? If it can only be used for one, let's make sure the choice of earlycon vs KGDB is intentional rather than accidental.
>>
>> I just sent the DBG2 series.  It enables an earlycon on DBG2 port with
>> an "earlycon=acpi_dbg2" option (we can discuss particular name).
>> If you need KGDB on that port just support it for that port in the kernel
>> (i. e. add a new instance of ACPI_DBG2_DECLARE() macros for that port, see the patches)
>> and change the command line options.
>> I hope that is OK.  We could continue this discussion in the DBG2 thread.
> 
> This method will not work for kgdb, since kgdb doesn't actually
> implement the i/o but rather runs on top of a console.

I see. Thank you for pointing this out.

I don't have requirements to implement running kgdb over the serial port
specified with DBG2.  This feature should be supported separately.

Thank you
Aleksey Makarov

>> [1] http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.den0044a/index.html
>> [2] http://go.microsoft.com/fwlink/p/?LinkId=234837
>>
>> Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
>> ---
>>  drivers/acpi/Kconfig              |  3 ++
>>  drivers/acpi/Makefile             |  1 +
>>  drivers/acpi/dbg2.c               | 88 +++++++++++++++++++++++++++++++++++++++
>>  include/asm-generic/vmlinux.lds.h |  1 +
>>  include/linux/acpi_dbg2.h         | 48 +++++++++++++++++++++
>>  5 files changed, 141 insertions(+)
>>  create mode 100644 drivers/acpi/dbg2.c
>>  create mode 100644 include/linux/acpi_dbg2.h
>>
>> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
>> index 65fb483..660666e 100644
>> --- a/drivers/acpi/Kconfig
>> +++ b/drivers/acpi/Kconfig
>> @@ -57,6 +57,9 @@ config ACPI_SYSTEM_POWER_STATES_SUPPORT
>>  config ACPI_CCA_REQUIRED
>>  	bool
>>  
>> +config ACPI_DBG2_TABLE
>> +	bool
>> +
>>  config ACPI_DEBUGGER
>>  	bool "AML debugger interface"
>>  	select ACPI_DEBUG
>> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
>> index 7395928..3b5f1ea 100644
>> --- a/drivers/acpi/Makefile
>> +++ b/drivers/acpi/Makefile
>> @@ -83,6 +83,7 @@ obj-$(CONFIG_ACPI_CUSTOM_METHOD)+= custom_method.o
>>  obj-$(CONFIG_ACPI_BGRT)		+= bgrt.o
>>  obj-$(CONFIG_ACPI_CPPC_LIB)	+= cppc_acpi.o
>>  obj-$(CONFIG_ACPI_DEBUGGER_USER) += acpi_dbg.o
>> +obj-$(CONFIG_ACPI_DBG2_TABLE)	+= dbg2.o
>>  
>>  # processor has its own "processor." module_param namespace
>>  processor-y			:= processor_driver.o
>> diff --git a/drivers/acpi/dbg2.c b/drivers/acpi/dbg2.c
>> new file mode 100644
>> index 0000000..0f0f6ca
>> --- /dev/null
>> +++ b/drivers/acpi/dbg2.c
>> @@ -0,0 +1,88 @@
>> +/*
>> + * Copyright (c) 2012, Intel Corporation
>> + * Copyright (c) 2015, 2016 Linaro Ltd.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + *
>> + */
>> +
>> +#define pr_fmt(fmt) "ACPI: DBG2: " fmt
>> +
>> +#include <linux/acpi_dbg2.h>
>> +#include <linux/acpi.h>
>> +#include <linux/kernel.h>
>> +
>> +static const char * __init type2string(u16 type)
>> +{
>> +	switch (type) {
>> +	case ACPI_DBG2_SERIAL_PORT:
>> +		return "SERIAL";
>> +	case ACPI_DBG2_1394_PORT:
>> +		return "1394";
>> +	case ACPI_DBG2_USB_PORT:
>> +		return "USB";
>> +	case ACPI_DBG2_NET_PORT:
>> +		return "NET";
>> +	default:
>> +		return "?";
>> +	}
>> +}
>> +
>> +static const char * __init subtype2string(u16 subtype)
>> +{
>> +	switch (subtype) {
>> +	case ACPI_DBG2_16550_COMPATIBLE:
>> +		return "16550_COMPATIBLE";
>> +	case ACPI_DBG2_16550_SUBSET:
>> +		return "16550_SUBSET";
>> +	case ACPI_DBG2_ARM_PL011:
>> +		return "ARM_PL011";
>> +	case ACPI_DBG2_ARM_SBSA_32BIT:
>> +		return "ARM_SBSA_32BIT";
>> +	case ACPI_DBG2_ARM_SBSA_GENERIC:
>> +		return "ARM_SBSA_GENERIC";
>> +	case ACPI_DBG2_ARM_DCC:
>> +		return "ARM_DCC";
>> +	case ACPI_DBG2_BCM2835:
>> +		return "BCM2835";
>> +	default:
>> +		return "?";
>> +	}
>> +}
>> +
>> +int __init acpi_dbg2_setup(struct acpi_table_header *table, const void *data)
>> +{
>> +	struct acpi_table_dbg2 *dbg2 = (struct acpi_table_dbg2 *)table;
>> +	struct acpi_dbg2_data *dbg2_data = (struct acpi_dbg2_data *)data;
>> +	struct acpi_dbg2_device *dbg2_device, *dbg2_end;
>> +	int i;
>> +
>> +	dbg2_device = ACPI_ADD_PTR(struct acpi_dbg2_device, dbg2,
>> +				   dbg2->info_offset);
>> +	dbg2_end = ACPI_ADD_PTR(struct acpi_dbg2_device, dbg2, table->length);
>> +
>> +	for (i = 0; i < dbg2->info_count; i++) {
>> +		if (dbg2_device + 1 > dbg2_end) {
>> +			pr_err("device pointer overflows, bad table\n");
>> +			return 0;
>> +		}
>> +
>> +		if (dbg2_device->port_type == dbg2_data->port_type &&
>> +		    dbg2_device->port_subtype == dbg2_data->port_subtype) {
>> +			if (dbg2_device->port_type == ACPI_DBG2_SERIAL_PORT)
>> +				pr_info("debug port: SERIAL; subtype: %s\n",
>> +				     subtype2string(dbg2_device->port_subtype));
>> +			else
>> +				pr_info("debug port: %s\n",
>> +					type2string(dbg2_device->port_type));
>> +			dbg2_data->setup(dbg2_device, dbg2_data->data);
>> +		}
>> +
>> +		dbg2_device = ACPI_ADD_PTR(struct acpi_dbg2_device, dbg2_device,
>> +					   dbg2_device->length);
>> +	}
>> +
>> +	return 0;
>> +}
>> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
>> index 8f5a12a..8cc49ba 100644
>> --- a/include/asm-generic/vmlinux.lds.h
>> +++ b/include/asm-generic/vmlinux.lds.h
>> @@ -526,6 +526,7 @@
>>  	IRQCHIP_OF_MATCH_TABLE()					\
>>  	ACPI_PROBE_TABLE(irqchip)					\
>>  	ACPI_PROBE_TABLE(clksrc)					\
>> +	ACPI_PROBE_TABLE(dbg2)						\
>>  	EARLYCON_TABLE()
>>  
>>  #define INIT_TEXT							\
>> diff --git a/include/linux/acpi_dbg2.h b/include/linux/acpi_dbg2.h
>> new file mode 100644
>> index 0000000..125ae7e
>> --- /dev/null
>> +++ b/include/linux/acpi_dbg2.h
>> @@ -0,0 +1,48 @@
>> +#ifndef _ACPI_DBG2_H_
>> +#define _ACPI_DBG2_H_
>> +
>> +#ifdef CONFIG_ACPI_DBG2_TABLE
>> +
>> +#include <linux/kernel.h>
>> +
>> +struct acpi_dbg2_device;
>> +struct acpi_table_header;
>> +
>> +struct acpi_dbg2_data {
>> +	u16 port_type;
>> +	u16 port_subtype;
>> +	int (*setup)(struct acpi_dbg2_device *, void *);
>> +	void *data;
>> +};
>> +
>> +int acpi_dbg2_setup(struct acpi_table_header *header, const void *data);
>> +
>> +/**
>> + * ACPI_DBG2_DECLARE() - Define handler for ACPI DBG2 port
>> + * @name:	Identifier to compose name of table data
>> + * @type:	Type of the port
>> + * @subtype:	Subtype of the port
>> + * @setup_fn:	Function to be called to setup the port
>> + *		(of type int (*)(struct acpi_dbg2_device *, void *);)
>> + * @data_ptr:	Sideband data provided back to the driver
>> + */
>> +#define ACPI_DBG2_DECLARE(name, type, subtype, setup_fn, data_ptr)	\
>> +	static const struct acpi_dbg2_data				\
>> +		__acpi_dbg2_data_##name __used = {			\
>> +			.port_type = type,				\
>> +			.port_subtype = subtype,			\
>> +			.setup = setup_fn,				\
>> +			.data = data_ptr,				\
>> +		   };							\
>> +	ACPI_DECLARE_PROBE_ENTRY(dbg2, name, ACPI_SIG_DBG2,		\
>> +				 acpi_dbg2_setup, &__acpi_dbg2_data_##name)
>> +
>> +#else
>> +
>> +#define ACPI_DBG2_DECLARE(name, type, subtype, setup_fn, data_ptr)	\
>> +	static const void *__acpi_dbg_data_##name[]			\
>> +		__used __initdata = { (void *)setup_fn,	(void *)data_ptr }
>> +
>> +#endif
>> +
>> +#endif
>>
> 
